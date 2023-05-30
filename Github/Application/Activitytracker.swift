//
//  Activitytracker.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableConvertibleType {
    func trackActivity(_ activityTracker: ActivityTracker) -> Observable<Element> {
        return activityTracker.trackActivityOfObservable(self)
    }
}

/**
 Enables monitoring of sequence computation.

 If there is at least one sequence computation in progress, `true` will be sent.
 When all activities complete `false` will be sent.
 */
public final class ActivityTracker: SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    private let lock = NSRecursiveLock()

    private let counter = BehaviorSubject(value: 0)
    private let activityOverride = PublishSubject<Int>()
    private let loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        self.loading = Driver
            .of(
                counter.asDriver(onErrorJustReturn: 0),
                activityOverride.asDriver(onErrorJustReturn: 0)
            )
            .merge()
            .map { counter in counter > 0 }
            .distinctUntilChanged()
    }

    /// Keep activity tracking alive.
    /// Use this in cases of dependent chained observables
    /// so that the "waiting" state continues until the
    /// last observable completes. Usually call this in
    /// a "do.onNext" between observables.
    public func keepAlive() {
        lock.lock()
        activityOverride.onNext(1)
        lock.unlock()
    }

    /// For each observable track activity by initially incrementing
    /// (activity started) and storing a token which when the observable
    /// completes will decrement (activity ended).
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {

        // Examples of "using", ties the lifetime of the observable sequence
        // to an external resource which when disposed can take some further
        // action (in this case decrement and stop the activity)
        return Observable.using({ () -> ActivityToken<O.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }, observableFactory: { token in
            return token.asObservable()
        })
    }

    // Increment/start activity
    private func increment() {
        lock.lock()
        defer { lock.unlock() }

        let value = (try? counter.value()) ?? 0
        counter.onNext(value + 1)
    }

    /// Decrement/stop activity
    private func decrement() {
        lock.lock()
        defer { lock.unlock() }

        let value = (try? counter.value()) ?? 0
        counter.onNext(value - 1)
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return loading.distinctUntilChanged()
    }

}

/// The resource that is kept until the source observable finishes
/// at which time it disposes and calls the dispose action
/// which in this case is to decrement the activity tracker.
private struct ActivityToken<E>: ObservableConvertibleType, Disposable {

    private let _source: Observable<E>
    private let _dispose: Cancelable

    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }

    func dispose() {
        _dispose.dispose()
    }

    func asObservable() -> Observable<E> {
        return _source
    }
}

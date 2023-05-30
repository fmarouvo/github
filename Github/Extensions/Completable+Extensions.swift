//
//  Completable+Extensions.swift
//  Github
//
//  Created by Fausto Marouvo on 30/05/23.
//

import RxSwift
import RxCocoa

extension Completable {
    func asDriver(
        trackActivityWith activityTracker: ActivityTracker,
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Void> {
        return andThen(Single.just(()))
            .trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriver(
                onErrorRecover: { _ in
                    .empty()
                }
            )
    }
}

extension Single {
    func asDriver(
        trackActivityWith activityTracker: ActivityTracker,
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Element> {
        return trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriver(
                onErrorRecover: { _ in
                    .empty()
                }
            )
    }

    func asDriver(
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Element> {
        return trackError(errorTracker)
            .asDriver(onErrorRecover: { _ in
                .empty()
            })
    }
}

extension ObservableType {
    func asDriver(
        trackActivityWith activityTracker: ActivityTracker,
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Element> {
        return trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriver(
                onErrorRecover: { _ in
                    .empty()
                }
            )
    }
}

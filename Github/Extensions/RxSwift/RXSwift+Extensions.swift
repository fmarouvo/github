//
//  RXSwift+Extensions.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import RxSwift
import RxCocoa

// MARK: - Codable Extensions

public extension PrimitiveSequence where Element == Data, Trait == SingleTrait {
    func decoded<T: Decodable>(to type: T.Type, using decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
        return map { try decoder.decode(type, from: $0) }
    }
}

public extension PrimitiveSequence where Element: Encodable, Trait == SingleTrait {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) -> Single<Data> {
        return map { try encoder.encode($0) }
    }
}

public extension ObservableType where Element == Data {
    func decoded<T: Decodable>(to type: T.Type, using decoder: JSONDecoder) -> Observable<T> {
        return map { try decoder.decode(type, from: $0) }
    }
}

public extension ObservableType where Element: Encodable {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) -> Observable<Data> {
        return map { try encoder.encode($0) }
    }
}

public extension ObservableType where Element == Bool {
    func not() -> Observable<Bool> {
        return map(!)
    }
}

public extension ObservableType {

    func catchErrorJustComplete() -> Observable<Element> {
        return `catch` { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

}

public extension PrimitiveSequence where Trait == SingleTrait {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Single<Void> {
        return map { _ in }
    }

}

// MARK: - Optional Extensions

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

public extension Observable where Element: OptionalType {
    func skipNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }

    func whenNil(returns wrappedValue: Element.Wrapped) -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ??
                Observable<Element.Wrapped>.just(wrappedValue)
        }
    }
}

public extension SharedSequenceConvertibleType where Element: OptionalType {
    func skipNil() -> Driver<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Driver<Element.Wrapped>.just($0) } ?? Driver<Element.Wrapped>.empty()
        }
    }

    func whenNil(returns wrappedValue: Element.Wrapped) -> Driver<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Driver<Element.Wrapped>.just($0) } ?? Driver<Element.Wrapped>.just(wrappedValue)
        }
    }
}

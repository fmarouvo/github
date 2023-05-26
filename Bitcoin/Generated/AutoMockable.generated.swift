// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import CoreLocation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import RxSwift














class FetchMarketPriceUseCaseMock: FetchMarketPriceUseCase {

//MARK: - fetchMarketPriceUseCase

var fetchMarketPriceUseCaseCallsCount = 0
var fetchMarketPriceUseCaseCalled: Bool {
return fetchMarketPriceUseCaseCallsCount > 0
}
var fetchMarketPriceUseCaseReturnValue: Single<MarketPriceResponse>!
var fetchMarketPriceUseCaseClosure: (() -> Single<MarketPriceResponse>)?

func fetchMarketPriceUseCase() -> Single<MarketPriceResponse> {
fetchMarketPriceUseCaseCallsCount += 1
return fetchMarketPriceUseCaseClosure.map({ $0() }) ?? fetchMarketPriceUseCaseReturnValue
}

}
class FetchMarketPriceVariationUseCaseMock: FetchMarketPriceVariationUseCase {

//MARK: - fetchMarketPriceVariationUseCase

var fetchMarketPriceVariationUseCaseCallsCount = 0
var fetchMarketPriceVariationUseCaseCalled: Bool {
return fetchMarketPriceVariationUseCaseCallsCount > 0
}
var fetchMarketPriceVariationUseCaseReturnValue: Single<MarketPriceVariationResponse>!
var fetchMarketPriceVariationUseCaseClosure: (() -> Single<MarketPriceVariationResponse>)?

func fetchMarketPriceVariationUseCase() -> Single<MarketPriceVariationResponse> {
fetchMarketPriceVariationUseCaseCallsCount += 1
return fetchMarketPriceVariationUseCaseClosure.map({ $0() }) ?? fetchMarketPriceVariationUseCaseReturnValue
}

}
class HomeInteractableMock: HomeInteractable {

//MARK: - fetchMarketPriceUseCase

var fetchMarketPriceUseCaseCallsCount = 0
var fetchMarketPriceUseCaseCalled: Bool {
return fetchMarketPriceUseCaseCallsCount > 0
}
var fetchMarketPriceUseCaseReturnValue: Single<MarketPriceResponse>!
var fetchMarketPriceUseCaseClosure: (() -> Single<MarketPriceResponse>)?

func fetchMarketPriceUseCase() -> Single<MarketPriceResponse> {
fetchMarketPriceUseCaseCallsCount += 1
return fetchMarketPriceUseCaseClosure.map({ $0() }) ?? fetchMarketPriceUseCaseReturnValue
}

//MARK: - fetchMarketPriceVariationUseCase

var fetchMarketPriceVariationUseCaseCallsCount = 0
var fetchMarketPriceVariationUseCaseCalled: Bool {
return fetchMarketPriceVariationUseCaseCallsCount > 0
}
var fetchMarketPriceVariationUseCaseReturnValue: Single<MarketPriceVariationResponse>!
var fetchMarketPriceVariationUseCaseClosure: (() -> Single<MarketPriceVariationResponse>)?

func fetchMarketPriceVariationUseCase() -> Single<MarketPriceVariationResponse> {
fetchMarketPriceVariationUseCaseCallsCount += 1
return fetchMarketPriceVariationUseCaseClosure.map({ $0() }) ?? fetchMarketPriceVariationUseCaseReturnValue
}

}

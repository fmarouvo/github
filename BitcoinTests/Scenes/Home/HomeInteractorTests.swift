//
//  HomeInteractorTests.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/20/20.

@testable import Bitcoin
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class HomeInteractorTests: XCTestCase {
    private var sut: HomeInteractor!
    private var disposeBag: DisposeBag!
    private var marketPriceUseCase: FetchMarketPriceUseCaseMock!
    private var marketPriceVariationUseCase: FetchMarketPriceVariationUseCaseMock!

    private var marketPriceResponseExpected: MarketPriceResponse!
    private var marketPriceVariationResponseExpected: MarketPriceVariationResponse!

    override func setUp() {
        super.setUp()
        setupHomeInteractor()
        let date = Date()
        let price = 10.0
        marketPriceResponseExpected = MarketPriceResponse(marketPrice: price, updatedAt: date)
        marketPriceVariationResponseExpected = MarketPriceVariationResponse(
            marketPriceValues: [MarketPriceValues(
                                    date: 1603065600,
                                    value: 11508.2)
            ])
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupHomeInteractor() {
        disposeBag = DisposeBag()
        marketPriceUseCase = FetchMarketPriceUseCaseMock()
        marketPriceVariationUseCase = FetchMarketPriceVariationUseCaseMock()
        sut = HomeInteractor(
            marketPriceUseCase: marketPriceUseCase,
            marketPriceVariationUseCase: marketPriceVariationUseCase
        )
    }

    func test_shouldFetchMarketPrice_success() {
        marketPriceUseCase.fetchMarketPriceUseCaseReturnValue = Single.just(marketPriceResponseExpected )
        sut.fetchMarketPriceUseCase()
            .subscribe(onSuccess: { _ in
                XCTAssert(true)
            })
            .disposed(by: disposeBag)
    }
    
    func test_shouldFetchMarketPriceVariation_success() {
        marketPriceVariationUseCase.fetchMarketPriceVariationUseCaseReturnValue = Single.just(marketPriceVariationResponseExpected )
        sut.fetchMarketPriceVariationUseCase()
            .subscribe(onSuccess: { _ in
                XCTAssert(true)
            })
            .disposed(by: disposeBag)
    }
}

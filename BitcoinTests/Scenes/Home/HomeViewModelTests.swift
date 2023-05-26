//
//  HomeViewModelTests.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/20/20.


@testable import Bitcoin
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: HomeInteractableMock!

    var onMarketPriceFetched: TestableObserver<MarketPriceResponse>!
    var onMarketPriceVariationFetched: TestableObserver<[MarketPriceValues]>!
    
    private var marketPriceResponseExpected: MarketPriceResponse!
    private var marketPriceVariationResponseExpected: MarketPriceVariationResponse!
    
    override func setUp() {
        super.setUp()
        setupHomeViewModel()
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

    private func setupHomeViewModel() {
        disposeBag = DisposeBag()
        interactor = HomeInteractableMock()
        sut = HomeViewModel(interactor: interactor)

        let scheduler = TestScheduler(initialClock: 0)

        onMarketPriceFetched = scheduler.createObserver(MarketPriceResponse.self)
        sut.output.onMarketPriceFetched.drive(onMarketPriceFetched).disposed(by: disposeBag)
        
        onMarketPriceVariationFetched = scheduler.createObserver([MarketPriceValues].self)
        sut.output.onMarketPriceVariationFetched.drive(onMarketPriceVariationFetched).disposed(by: disposeBag)

        scheduler.start()
    }

    func test_onMarketPriceFetched_success() {
        interactor.fetchMarketPriceUseCaseReturnValue = Single.just(marketPriceResponseExpected)
        
        sut.fetchMarketPrice.onNext(())
        
        XCTAssertEqual(onMarketPriceFetched.events.first?.value.element, marketPriceResponseExpected)
    }
    
    func test_onMarketPriceVariationFetched_success() {
        interactor.fetchMarketPriceVariationUseCaseReturnValue = Single.just(marketPriceVariationResponseExpected)
        
        sut.fetchMarketPriceVariation.onNext(())
        
        XCTAssertEqual(onMarketPriceVariationFetched.events.first?.value.element, marketPriceVariationResponseExpected.marketPriceValues)
    }
    
}

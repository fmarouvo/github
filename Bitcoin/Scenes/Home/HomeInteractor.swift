//
//  HomeInteractor.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol HomeInteractable: AnyObject, FetchMarketPriceUseCase, FetchMarketPriceVariationUseCase {}

final class HomeInteractor: HomeInteractable {
    private let marketPriceUseCase: FetchMarketPriceUseCase
    private let marketPriceVariationUseCase: FetchMarketPriceVariationUseCase
    
    init(marketPriceUseCase: FetchMarketPriceUseCase, marketPriceVariationUseCase: FetchMarketPriceVariationUseCase) {
        self.marketPriceUseCase = marketPriceUseCase
        self.marketPriceVariationUseCase = marketPriceVariationUseCase
    }
    
    func fetchMarketPriceUseCase() -> Single<MarketPriceResponse> {
        marketPriceUseCase.fetchMarketPriceUseCase()
    }
    
    func fetchMarketPriceVariationUseCase() -> Single<MarketPriceVariationResponse> {
        marketPriceVariationUseCase.fetchMarketPriceVariationUseCase()
    }
}

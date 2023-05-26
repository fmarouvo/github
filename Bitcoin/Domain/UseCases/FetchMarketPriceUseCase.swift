//
//  FetchMarketPriceUseCase.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol FetchMarketPriceUseCase {
    func fetchMarketPriceUseCase() -> Single<MarketPriceResponse>
}

final class FetchMarketPriceUseCaseImpl: FetchMarketPriceUseCase {
    
    let apiClient = ApiClient()
    let repository = LocalRepository()
    
    func fetchMarketPriceUseCase() -> Single<MarketPriceResponse> {
        apiClient.requestSingle(BitcoinRouter.fetchStats, type: MarketPriceResponse.self)
            .flatMap { marketPrice in
                self.repository.saveMarketPrice(data: marketPrice)
            }
          
    }
}

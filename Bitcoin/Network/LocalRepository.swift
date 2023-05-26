//
//  LocalRepository.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation
import RxSwift

final class LocalRepository {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    enum Keys: String {
        case marketPrice
        case marketPriceVariation
    }
    
    func saveMarketPrice(data: MarketPriceResponse) -> Single<MarketPriceResponse> {
        clearMarketPriceRepository()
        let data = try? encoder.encode(data)
        UserDefaults.standard.set(data, forKey: Keys.marketPrice.rawValue)
        return Single.just(fetchMarketPrice())
    }
    
    func saveMarketPriceVariation(data: MarketPriceVariationResponse) -> Single<MarketPriceVariationResponse> {
        clearMarketPriceVariationRepository()
        let data = try? encoder.encode(data)
        UserDefaults.standard.set(data, forKey: Keys.marketPriceVariation.rawValue)
        return Single.just(fetchMarketPriceVariation())
    }
    
    private func fetchMarketPrice() -> MarketPriceResponse {
        if let data = UserDefaults.standard.data(forKey: Keys.marketPrice.rawValue) {
            do {
                let marketPrice = try decoder.decode(MarketPriceResponse.self, from: data)
                return marketPrice
            } catch {
                print("Unable to Decode MarketPriceResponse (\(error))")
            }
        }
        return MarketPriceResponse(marketPrice: 0, updatedAt: Date())
    }
    
    private func fetchMarketPriceVariation() -> MarketPriceVariationResponse {
        if let data = UserDefaults.standard.data(forKey: Keys.marketPriceVariation.rawValue) {
            do {
                let marketPriceVariation = try decoder.decode(MarketPriceVariationResponse.self, from: data)
                return marketPriceVariation
            } catch {
                print("Unable to Decode MarketPriceVariationResponse (\(error))")
            }
        }
        return MarketPriceVariationResponse(marketPriceValues: [])
    }
    
    private func clearMarketPriceRepository() {
        UserDefaults.standard.removeObject(forKey: Keys.marketPrice.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func clearMarketPriceVariationRepository() {
        UserDefaults.standard.removeObject(forKey: Keys.marketPriceVariation.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}

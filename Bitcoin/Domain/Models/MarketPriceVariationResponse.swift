//
//  MarketPriceVariationResponse.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation

struct MarketPriceVariationResponse: Codable, Equatable {
    let marketPriceValues: [MarketPriceValues]
    
    enum CodingKeys: String, CodingKey {
        case marketPriceValues = "values"
    }
}

struct MarketPriceValues: Codable, Equatable {
    let date: TimeInterval
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "x"
        case value = "y"
    }
    
    func dateToString(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: date)
    }
}

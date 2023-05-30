//
//  BitcoinRouter.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation
import UIKit
import Alamofire

enum BitcoinRouter {
    case fetchStats
    case fetchMarketPrice
}

extension BitcoinRouter: RouterType {
    
    var path: String {
        switch self {
        case .fetchStats: return "stats"
        case .fetchMarketPrice: return "charts/market-price?timespan=1week"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchStats: return .get
        case .fetchMarketPrice: return .get
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .fetchStats, .fetchMarketPrice: return nil
        }
    }
    
    var paramsArray: [[String: Any]]? { return nil }
    var paramsQueryString: [String: Any]? { return nil }
}

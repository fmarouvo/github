//
//  Double+String.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation

extension Double {
    func convertToMoneyWithTwoDecimals() -> String {
        let currencyFormatter = NumberFormatter()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = ""
        
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let doubleString = String(format: "%.\(places)f", self)
        
        return Double(doubleString) ?? 0
    }
    
}

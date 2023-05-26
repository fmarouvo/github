//
//  Date+String.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/20/20.
//

import Foundation

extension Date {
    func formatted(using dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    func dateFromTimestamp() -> Date {
        
        let timestamp = Int64(self.timeIntervalSinceReferenceDate / 1000)
        
        let myTimeInterval = TimeInterval(timestamp)
        return NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval)) as Date
        
    }
}

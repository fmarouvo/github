//
//  DateValueFormatter.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/20/20.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MMM dd"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

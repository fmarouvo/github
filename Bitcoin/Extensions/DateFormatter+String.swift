//
//  DateFormatter+String.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/20/20.
//

import Foundation

extension DateFormatter {
    static func with(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = ptBrLocale
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter
    }

    static let ptBrLocale = Locale(identifier: "pt_BR")

    /// Format date as `dd/MM/yyyy 'às' HH:mm:ss`
    static let dateAndTime = DateFormatter.with(format: "dd/MM/yyyy 'às' HH:mm:ss")
}

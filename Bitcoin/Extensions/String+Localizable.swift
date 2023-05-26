//
//  String+Localizable.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/20/20.
//

import Foundation

extension String {

     func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
     }

     var localized: String{
         return Bundle.main.localizedString(forKey: self, value: nil, table: "StandardLocalizations")
     }
}

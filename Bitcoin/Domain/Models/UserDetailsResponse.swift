//
//  UserDetailsResponse.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation

struct UserDetailsResponse: Codable, Equatable {
    let login: String
    let id: Int
    let avatar_url: String?
    let company: String?
    let location: String?
}

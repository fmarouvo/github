//
//  UserRepositoriesResponse.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation

struct UserRepositoriesResponse: Codable, Equatable {
    let name: String
    let description: String?
    let updated_at: String? // "2023-05-07T20:51:28Z"
    let watchers: Int?
}

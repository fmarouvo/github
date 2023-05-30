//
//  UserRepositoriesResponse.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation

struct UserRepositoriesResponse: Codable, Equatable {
    let name: String
    let description: String?
    let updated_at: String?
    let watchers: Int?
}

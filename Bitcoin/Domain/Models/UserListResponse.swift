//
//  UserListResponse.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation

struct UserListResponse: Codable, Equatable {
    let users: [UserResponse]
}

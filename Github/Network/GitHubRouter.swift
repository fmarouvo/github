//
//  GitHubRouter.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import UIKit
import Alamofire

enum GitHubRouter {
    case fetchUserList
    case fetchUserDetails(login: String)
    case fetchUserRepositories(login: String)
}

extension GitHubRouter: RouterType {

    var path: String {
        switch self {
        case .fetchUserList: return "users"
        case let .fetchUserDetails(login): return "users/\(login)"
        case let .fetchUserRepositories(login): return "users/\(login)/repos"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchUserList: return .get
        case .fetchUserDetails: return .get
        case .fetchUserRepositories: return .get
        }
    }

    var params: [String: Any]? {
        switch self {
        case .fetchUserList, .fetchUserDetails, .fetchUserRepositories: return nil
        }
    }

    var paramsArray: [[String: Any]]? { return nil }
    var paramsQueryString: [String: Any]? { return nil }
}

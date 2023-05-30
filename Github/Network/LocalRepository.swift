//
//  LocalRepository.swift
//  Github
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation
import RxSwift

final class LocalRepository {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    enum Keys: String {
        case userList
        case userDetails
        case userRepositories
    }
    
    func saveUserList(data: [UserResponse]) -> Single<[UserResponse]> {
        clearUserList()
        let data = try? encoder.encode(data)
        UserDefaults.standard.set(data, forKey: Keys.userList.rawValue)
        return Single.just(fetchUserList())
    }

    func saveUserDetails(data: UserDetailsResponse) -> Single<UserDetailsResponse> {
        clearUserDetails()
        let data = try? encoder.encode(data)
        UserDefaults.standard.set(data, forKey: Keys.userDetails.rawValue)
        return Single.just(fetchUserDetails())
    }

    func saveUserRepositories(data: [UserRepositoriesResponse]) -> Single<[UserRepositoriesResponse]> {
        clearUserRepositories()
        let data = try? encoder.encode(data)
        UserDefaults.standard.set(data, forKey: Keys.userRepositories.rawValue)
        return Single.just(fetchUserRepositories())
    }
    
    func fetchUserList() -> [UserResponse] {
        if let data = UserDefaults.standard.data(forKey: Keys.userList.rawValue) {
            do {
                let userList = try decoder.decode([UserResponse].self, from: data)
                return userList
            } catch {
                print("Unable to Decode MarketPriceVariationResponse (\(error))")
            }
        }
        return []
    }

    func fetchUserDetails() -> UserDetailsResponse {
        if let data = UserDefaults.standard.data(forKey: Keys.userDetails.rawValue) {
            do {
                let userDetails = try decoder.decode(UserDetailsResponse.self, from: data)
                return userDetails
            } catch {
                print("Unable to Decode MarketPriceVariationResponse (\(error))")
            }
        }
        return UserDetailsResponse(login: "", id: 0, avatar_url: "", company: "", location: "")
    }

    func fetchUserRepositories() -> [UserRepositoriesResponse] {
        if let data = UserDefaults.standard.data(forKey: Keys.userRepositories.rawValue) {
            do {
                let userRepositories = try decoder.decode([UserRepositoriesResponse].self, from: data)
                return userRepositories
            } catch {
                print("Unable to Decode MarketPriceVariationResponse (\(error))")
            }
        }
        return []
    }
    
    private func clearUserDetails() {
        UserDefaults.standard.removeObject(forKey: Keys.userDetails.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func clearUserList() {
        UserDefaults.standard.removeObject(forKey: Keys.userList.rawValue)
        UserDefaults.standard.synchronize()
    }

    private func clearUserRepositories() {
        UserDefaults.standard.removeObject(forKey: Keys.userRepositories.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}

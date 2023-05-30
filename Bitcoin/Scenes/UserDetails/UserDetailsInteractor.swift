//
//  UserDetailsInteractor.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol UserDetailsInteractable: AnyObject {
    func fetchUserDetails(login: String) -> Single<UserDetailsResponse>
    func fetchUserRepositories(login: String) -> Single<[UserRepositoriesResponse]>
}

final class UserDetailsInteractor: UserDetailsInteractable, FetchUserDetailsUseCase {

    private let fetchUserDetailsUseCase: FetchUserDetailsUseCase
    private let fetchUserRepositoriesUseCase: FetchUserRepositoriesUseCase
    
    init(fetchUserDetailsUseCase: FetchUserDetailsUseCase, fetchUserRepositoriesUseCase: FetchUserRepositoriesUseCase) {
        self.fetchUserDetailsUseCase = fetchUserDetailsUseCase
        self.fetchUserRepositoriesUseCase = fetchUserRepositoriesUseCase
    }

    func fetchUserDetails(login: String) -> Single<UserDetailsResponse> {
        fetchUserDetailsUseCase.fetchUserDetails(login: login)
    }

    func fetchUserRepositories(login: String) -> Single<[UserRepositoriesResponse]> {
        fetchUserRepositoriesUseCase.fetchUserRepositories(login: login)
    }
}

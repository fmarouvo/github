//
//  UserRepositoriesUseCase.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol UserRepositoriesUseCase {
    func fetchUserListUseCase(login: String) -> Single<UserRepositoriesResponse>
}

final class UserRepositoriesUseCaseImpl: UserRepositoriesUseCase {

    let apiClient = ApiClient()
    let repository = LocalRepository()

    func fetchUserListUseCase(login: String) -> Single<UserRepositoriesResponse> {
        apiClient.requestSingle(GitHubRouter.fetchUserRepositories(login: login), type: UserRepositoriesResponse.self)
            .flatMap { userRepositories in
                self.repository.saveUserRepositories(data: userRepositories)
            }
    }
}

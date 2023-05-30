//
//  FetchUserRepositoriesUseCase.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol FetchUserRepositoriesUseCase {
    func fetchUserRepositories(login: String) -> Single<[UserRepositoriesResponse]>
}

final class FetchUserRepositoriesUseCaseImpl: FetchUserRepositoriesUseCase {

    let apiClient = ApiClient()
    let repository = LocalRepository()

    func fetchUserRepositories(login: String) -> Single<[UserRepositoriesResponse]> {
        apiClient.requestSingle(GitHubRouter.fetchUserRepositories(login: login), type: [UserRepositoriesResponse].self)
            .flatMap { userRepositories in
                self.repository.saveUserRepositories(data: userRepositories)
            }
    }
}

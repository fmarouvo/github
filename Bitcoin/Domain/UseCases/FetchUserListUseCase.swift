//
//  FetchUserListUseCase.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol FetchUserListUseCase {
    func fetchUserListUseCase() -> Single<UserListResponse>
}

final class FetchUserListUseCaseImpl: FetchUserListUseCase {

    let apiClient = ApiClient()
    let repository = LocalRepository()

    func fetchUserListUseCase() -> Single<UserListResponse> {
        apiClient.requestSingle(GitHubRouter.fetchUserList, type: UserListResponse.self)
            .flatMap { user in
                self.repository.saveUserList(data: user)
            }
    }

}

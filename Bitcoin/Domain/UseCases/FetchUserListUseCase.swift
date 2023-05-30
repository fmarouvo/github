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
    func fetchUserList() -> Single<[UserResponse]>
}

final class FetchUserListUseCaseImpl: FetchUserListUseCase {

    let apiClient = ApiClient()
    let repository = LocalRepository()

    func fetchUserList() -> Single<[UserResponse]> {
        apiClient.requestSingle(GitHubRouter.fetchUserList, type: [UserResponse].self)
            .flatMap { userList in
                self.repository.saveUserList(data: userList)
            }
    }

}

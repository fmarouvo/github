//
//  FetchUserDetailsUseCase.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol FetchUserDetailsUseCase {
    func fetchUserDetails(login: String) -> Single<UserDetailsResponse>
}

final class FetchUserDetailsUseCaseImpl: FetchUserDetailsUseCase {

    let apiClient = ApiClient()
    let repository = LocalRepository()

    func fetchUserDetails(login: String) -> Single<UserDetailsResponse> {
        apiClient.requestSingle(GitHubRouter.fetchUserDetails(login: login), type: UserDetailsResponse.self)
            .flatMap { userDetails in
                self.repository.saveUserDetails(data: userDetails)
            }
    }
}

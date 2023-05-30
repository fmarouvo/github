//
//  UserDetailsViewModel.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserDetailsViewModelInput: AnyObject {
    var fetchUserDetails: PublishSubject<String> { get }
    var fetchUserRepositories: PublishSubject<String> { get }
}

protocol UserDetailsViewModelOutput: AnyObject {
    var onUserDetailsFetched: Driver<UserDetailsResponse> { get }
    var onUserRepositoriesFetched: Driver<[UserRepositoriesResponse]> { get }
}

protocol UserDetailsViewModelType: AnyObject {
    var input: UserDetailsViewModelInput { get }
    var output: UserDetailsViewModelOutput { get }
}

class UserDetailsViewModel: UserDetailsViewModelType, UserDetailsViewModelInput, UserDetailsViewModelOutput {

    let onUserDetailsFetched: Driver<UserDetailsResponse>
    let onUserRepositoriesFetched: Driver<[UserRepositoriesResponse]>

    init(interactor: UserDetailsInteractable) {

        onUserDetailsFetched = fetchUserDetails.asDriver(onErrorJustReturn: "")
            .flatMap { login in
                interactor.fetchUserDetails(login: login)
                    .asDriver(onErrorJustReturn: UserDetailsResponse(login: "", id: 0, avatar_url: "", company: "", location: ""))
            }
        onUserRepositoriesFetched = fetchUserRepositories.asDriver(onErrorJustReturn: "")
            .flatMap { login in
                interactor.fetchUserRepositories(login: login)
                    .asDriver(onErrorJustReturn: [])
            }

    }

    let fetchUserDetails: PublishSubject<String> = PublishSubject()
    let fetchUserRepositories: PublishSubject<String> = PublishSubject()

    var input: UserDetailsViewModelInput { return self }
    var output: UserDetailsViewModelOutput { return self }
}

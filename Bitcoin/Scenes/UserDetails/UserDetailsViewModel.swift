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
    var isLoading: Driver<Bool> { get }
    var error: Driver<Error> { get }
}

protocol UserDetailsViewModelType: AnyObject {
    var input: UserDetailsViewModelInput { get }
    var output: UserDetailsViewModelOutput { get }
}

class UserDetailsViewModel: UserDetailsViewModelType, UserDetailsViewModelInput, UserDetailsViewModelOutput {

    let onUserDetailsFetched: Driver<UserDetailsResponse>
    let onUserRepositoriesFetched: Driver<[UserRepositoriesResponse]>
    let isLoading: Driver<Bool>
    let error: Driver<Error>

    init(interactor: UserDetailsInteractable) {
        let activityTracker = ActivityTracker()
        let activityTrackerRepos = ActivityTracker()
        isLoading = Driver.merge(activityTracker.asDriver(), activityTrackerRepos.asDriver())

        let errorTracker = ErrorTracker()
        let errorTrackerRepos = ErrorTracker()
        error = Driver.merge(errorTracker.asDriver(), errorTrackerRepos.asDriver())
        
        onUserDetailsFetched = fetchUserDetails.asDriverOnErrorJustComplete()
            .flatMap { login in
                interactor.fetchUserDetails(login: login)
                    .asDriver(trackActivityWith: activityTracker, onErrorTrackWith: errorTracker)
            }

        onUserRepositoriesFetched = fetchUserRepositories.asDriverOnErrorJustComplete()
            .flatMap { login in
                interactor.fetchUserRepositories(login: login)
                    .asDriver(trackActivityWith: activityTrackerRepos, onErrorTrackWith: errorTrackerRepos)
            }

    }

    let fetchUserDetails: PublishSubject<String> = PublishSubject()
    let fetchUserRepositories: PublishSubject<String> = PublishSubject()

    var input: UserDetailsViewModelInput { return self }
    var output: UserDetailsViewModelOutput { return self }
}

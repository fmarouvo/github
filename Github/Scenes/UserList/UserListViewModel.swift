//
//  UserListViewModel.swift
//  Github
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserListViewModelInput: AnyObject {
    var fetchUserList: PublishSubject<Void> { get }
}

protocol UserListViewModelOutput: AnyObject {
    var onUserListFetched: Driver<[UserResponse]> { get }
    var isLoading: Driver<Bool> { get }
    var error: Driver<Error> { get }
}

protocol UserListViewModelType: AnyObject {
    var input: UserListViewModelInput { get }
    var output: UserListViewModelOutput { get }
}

class UserListViewModel: UserListViewModelType, UserListViewModelInput, UserListViewModelOutput {

    let onUserListFetched: Driver<[UserResponse]>
    let isLoading: Driver<Bool>
    let error: Driver<Error>

    init(interactor: UserListInteractable) {
        let activityTracker = ActivityTracker()
        isLoading = activityTracker.asDriver()

        let errorTracker = ErrorTracker()
        error = errorTracker.asDriver()

        onUserListFetched = fetchUserList.asDriverOnErrorJustComplete()
            .flatMap { _ in
                interactor.fetchUserList()
                    .asDriver(trackActivityWith: activityTracker, onErrorTrackWith: errorTracker)
            }
    }

    let fetchUserList: PublishSubject<Void> = PublishSubject()

    var input: UserListViewModelInput { return self }
    var output: UserListViewModelOutput { return self }
}

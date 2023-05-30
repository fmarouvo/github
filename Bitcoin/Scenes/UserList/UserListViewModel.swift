//
//  UserListViewModel.swift
//  Bitcoin
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
}

protocol UserListViewModelType: AnyObject {
    var input: UserListViewModelInput { get }
    var output: UserListViewModelOutput { get }
}

class UserListViewModel: UserListViewModelType, UserListViewModelInput, UserListViewModelOutput {

    let onUserListFetched: Driver<[UserResponse]>

    init(interactor: UserListInteractable) {

        onUserListFetched = fetchUserList.asDriver(onErrorJustReturn: Void())
            .flatMap { _ in
                interactor.fetchUserList()
                    .asDriver(onErrorJustReturn: [])
            }

    }

    let fetchUserList: PublishSubject<Void> = PublishSubject()

    var input: UserListViewModelInput { return self }
    var output: UserListViewModelOutput { return self }
}

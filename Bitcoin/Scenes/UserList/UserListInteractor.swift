//
//  UserListInteractor.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol UserListInteractable: AnyObject {
    func fetchUserList() -> Single<[UserResponse]>
}

final class UserListInteractor: UserListInteractable, FetchUserListUseCase {

    private let fetchUserListUseCase: FetchUserListUseCase

    init(fetchUserListUseCase: FetchUserListUseCase) {
        self.fetchUserListUseCase = fetchUserListUseCase
    }

    func fetchUserList() -> Single<[UserResponse]> {
        fetchUserListUseCase.fetchUserList()
    }

}

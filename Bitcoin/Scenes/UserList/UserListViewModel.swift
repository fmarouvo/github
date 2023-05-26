//
//  UserListViewModel.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserListViewModelInput: AnyObject {}

protocol UserListViewModelOutput: AnyObject {}

protocol UserListViewModelType: AnyObject {
    var input: UserListViewModelInput { get }
    var output: UserListViewModelOutput { get }
}

class UserListViewModel: UserListViewModelType, UserListViewModelInput, UserListViewModelOutput {
    init(interactor: UserListInteractable) {}

    var input: UserListViewModelInput { return self }
    var output: UserListViewModelOutput { return self }
}

//
//  UserListBuilder.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import UIKit

protocol UserListBuildable: AnyObject {
    func build() -> UIViewController
}

final class UserListBuilder: Builder, UserListBuildable {
    func build() -> UIViewController {
        let interactor = UserListInteractor(fetchUserListUseCase: FetchUserListUseCaseImpl())

        let viewModel = UserListViewModel(interactor: interactor)

        let viewController = UserListViewController(withViewModel: viewModel)

        return viewController
    }
}

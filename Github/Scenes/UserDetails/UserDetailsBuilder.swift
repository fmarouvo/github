//
//  UserDetailsBuilder.swift
//  Github
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import UIKit

protocol UserDetailsBuildable: AnyObject {
    func build(userLogin: String) -> UIViewController
}

final class UserDetailsBuilder: Builder, UserDetailsBuildable {
    func build(userLogin: String) -> UIViewController {
        let interactor = UserDetailsInteractor(
            fetchUserDetailsUseCase: FetchUserDetailsUseCaseImpl(),
            fetchUserRepositoriesUseCase: FetchUserRepositoriesUseCaseImpl()
        )

        let viewModel = UserDetailsViewModel(interactor: interactor)

        let viewController = UserDetailsViewController(withViewModel: viewModel, userLogin: userLogin)

        return viewController
    }
}

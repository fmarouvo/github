//
//  UserDetailsBuilder.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import UIKit

protocol UserDetailsBuildable: AnyObject {
    func build() -> UIViewController
}

final class UserDetailsBuilder: Builder, UserDetailsBuildable {
    func build() -> UIViewController {
        let interactor = UserDetailsInteractor()

        let viewModel = UserDetailsViewModel(interactor: interactor)

        let viewController = UserDetailsViewController(withViewModel: viewModel)

        return viewController
    }
}

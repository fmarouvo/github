//
//  UserDetailsViewModel.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserDetailsViewModelInput: AnyObject {}

protocol UserDetailsViewModelOutput: AnyObject {}

protocol UserDetailsViewModelType: AnyObject {
    var input: UserDetailsViewModelInput { get }
    var output: UserDetailsViewModelOutput { get }
}

class UserDetailsViewModel: UserDetailsViewModelType, UserDetailsViewModelInput, UserDetailsViewModelOutput {
    init(interactor: UserDetailsInteractable) {}

    var input: UserDetailsViewModelInput { return self }
    var output: UserDetailsViewModelOutput { return self }
}

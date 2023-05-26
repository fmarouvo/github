//
//  HomeBuilder.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import Foundation
import UIKit

class Builder {}

protocol HomeBuildable: AnyObject {
    func build() -> UIViewController
}

final class HomeBuilder: Builder, HomeBuildable {
    func build() -> UIViewController {
        let interactor = HomeInteractor(
            marketPriceUseCase: FetchMarketPriceUseCaseImpl(),
            marketPriceVariationUseCase: FetchMarketPriceVariationUseCaseImpl())
        
        let viewModel = HomeViewModel(interactor: interactor)

        let viewController = HomeViewController(withViewModel: viewModel)

        return viewController
    }
}

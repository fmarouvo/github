//
//  LoadingViewController.swift
//  Github
//
//  Created by Fausto Marouvo on 30/05/23.
//

import UIKit
import RxSwift
import UIKit

class LoadingViewController: UIViewController {

    class Constants {
        static let indicatorXAnchor = 10
        static let indicatorYAnchor = 5
        static let indicatorSizeAnchor = 50
    }

    let alert = UIAlertController(title: nil, message: L10n.Common.Loading.message, preferredStyle: .alert)
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: Constants.indicatorXAnchor, y: Constants.indicatorYAnchor, width: Constants.indicatorSizeAnchor, height: Constants.indicatorSizeAnchor))

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAnimation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func prepareAnimation() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}

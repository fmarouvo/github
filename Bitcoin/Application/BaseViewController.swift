//
//  BaseViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 29/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    let isLoading = BehaviorRelay(value: true)
    let error: PublishSubject<Error> = PublishSubject()

    private lazy var loadingViewController = makeLoadingViewController()
    private var isLoadingActive = false

    override func viewDidLoad() {
        prepareViewModel()
    }

    func prepareViewModel() {
        isLoading.asDriver()
            .skip(1)
            .drive(onNext: { [weak self] in
                self?.loadingChanged($0)
            })
            .disposed(by: disposeBag)

        error.asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)

    }

    func makeLoadingViewController() -> LoadingViewController {
        return LoadingViewController()
    }

    func showLoading() {
        if !isLoadingActive {
            add(loadingViewController)
            loadingViewController.view.translatesAutoresizingMaskIntoConstraints = false
            loadingViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive.toggle()
            loadingViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive.toggle()
            loadingViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive.toggle()
            loadingViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive.toggle()
            isLoadingActive = true
        }
    }

    func hideLoading() {
        if isLoadingActive {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.loadingViewController.dismiss(animated: true) {
                    self.loadingViewController.remove()
                    self.isLoadingActive = false
                }
            }
        }
    }

    func loadingChanged(_ isLoading: Bool) {
        if isLoading {
            view.endEditing(true)
            showLoading()
        } else {
            hideLoading()
        }
    }

    func handleError(_ error: Error, onConfirm: (() -> Void)? = nil) {
        dump(error)
        view.displayToast(error.localizedDescription)
    }
}

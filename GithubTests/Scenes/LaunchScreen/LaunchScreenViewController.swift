//
//  LaunchScreenViewController.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    private let imageView = {
        let view = UIImageView()
        view.image = Constants.Image.logoGitHub
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.text = "GitHub"
        label.textColor = .black
        return label
    }()

    let creditsLabel = {
        let label = UILabel()
        label.text = "Fausto Castagnari Marouvo"
        label.font = label.font.withSize(Constants.Font.small)
        label.textColor = .black
        return label
    }()

    //MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        setupConstraints()
        routeToUserList()
    }

    //MARK: - Private Methods
    private func prepareViews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(creditsLabel)
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive.toggle()
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Constants.Size.big).isActive.toggle()
        imageView.widthAnchor.constraint(equalToConstant: Constants.Size.xxBig).isActive.toggle()
        imageView.heightAnchor.constraint(equalToConstant: Constants.Size.xxBig).isActive.toggle()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.Size.xSmall).isActive.toggle()
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive.toggle()

        creditsLabel.translatesAutoresizingMaskIntoConstraints = false
        creditsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.Size.xBig).isActive.toggle()
        creditsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Size.small).isActive.toggle()
    }

    func routeToUserList() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let navigationController = UINavigationController(rootViewController: UserListBuilder().build())
            navigationController.modalPresentationStyle = .fullScreen
            AppDelegate.sharedInstance().window?.rootViewController = navigationController
        }
    }
}

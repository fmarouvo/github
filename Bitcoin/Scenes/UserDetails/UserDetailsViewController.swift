//
//  UserDetailsViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit

class UserDetailsViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView()
    private let titleLabel = UILabel()

    private let viewModel: UserDetailsViewModelType

    init(withViewModel viewModel: UserDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        setupConstraints()
    }

    private func prepareViews() {
        view.addSubview(contentView)
        titleLabel.text = "Usuário XXXXXXXX"
        contentView.addSubview(titleLabel)
        contentView.addSubview(tableView)

        contentView.backgroundColor = .blue
        tableView.backgroundColor = .lightGray
    }

    private func setupConstraints() {
        /*scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive.toggle()
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive.toggle()
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive.toggle()
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive.toggle()*/

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive.toggle()
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive.toggle()
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive.toggle()
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive.toggle()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80).isActive.toggle()
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive.toggle()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20).isActive.toggle()
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive.toggle()
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive.toggle()
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive.toggle()

    }
}

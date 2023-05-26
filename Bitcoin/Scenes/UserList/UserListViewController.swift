//
//  UserListViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit

class UserListViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView()

    private let cellReuseIdentifier = "userListCell"

    private let viewModel: UserListViewModelType

    private let names = ["Name One", "Name Two", "Name Three", "Name Four", "Name Five", "Name Six", "Name Seven", "Name Eight", "Name Nine", "Name Ten"]

    init(withViewModel viewModel: UserListViewModelType) {
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
        prepareTableView()
    }

    private func prepareViews() {
        view.addSubview(contentView)
        //scrollView.addSubview(contentView)
        navigationItem.title = "User List"
        contentView.addSubview(tableView)

        //scrollView.backgroundColor = .red
        contentView.backgroundColor = UIColor(rgb: 0xf9f9f9)
        tableView.backgroundColor = .white
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

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive.toggle()
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive.toggle()
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive.toggle()
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive.toggle()

    }

    private func prepareTableView() {
        tableView.register(UserListCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        navigationController?.pushViewController(UserDetailsBuilder().build(), animated: true)
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UserListCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserListCell {
            cell.setupCell(text: names[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

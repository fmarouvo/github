//
//  UserListViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit

class UserListViewController: UIViewController {

    //MARK: - Private variables
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView()

    private let cellReuseIdentifier = "userListCell"

    private let viewModel: UserListViewModelType

    private let names = ["Name One", "Name Two", "Name Three", "Name Four", "Name Five", "Name Six", "Name Seven", "Name Eight", "Name Nine", "Name Ten"]

    //MARK: - Initialization
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

    //MARK: - Private Methods
    private func prepareViews() {
        view.addSubview(contentView)
        navigationItem.title = "User List"
        contentView.addSubview(tableView)

        contentView.backgroundColor = Constants.Color.topBackground
        tableView.backgroundColor = .white
    }

    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive.toggle()
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive.toggle()
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive.toggle()
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive.toggle()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Size.top).isActive.toggle()
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

//MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        navigationController?.pushViewController(UserDetailsBuilder().build(), animated: true)
    }
}

//MARK: - UITableViewDataSource
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

//
//  UserListViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit
import RxSwift

class UserListViewController: UIViewController {

    //MARK: - Private variables
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView()

    private let cellReuseIdentifier = "userListCell"
    private let emptyCellReuseIdentifier = "EmptyCell"
    private let emptyCellMessage = "Data is empty. Try again later."
    private let viewModel: UserListViewModelType
    private let disposeBag = DisposeBag()

    private var userList: [UserResponse] = []

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
        prepareViewModel()
        prepareTableView()
        fetchData()
    }

    //MARK: - Private Methods
    private func prepareViewModel() {
        viewModel.output.onUserListFetched
            .drive(onNext: { [weak self] userListResponse in
                guard let self = self else { return }
                self.userList = userListResponse
                if userListResponse.isEmpty {
                    self.userList = [UserResponse(login: emptyCellMessage, id: 0, avatar_url: "")]
                    return
                }
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func fetchData() {
        viewModel.input.fetchUserList.onNext(())
    }

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
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Size.xBig).isActive.toggle()
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive.toggle()
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive.toggle()
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive.toggle()

    }

    private func prepareTableView() {
        tableView.register(UserListCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: emptyCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        navigationController?.pushViewController(UserDetailsBuilder().build(userLogin: userList[indexPath.row].login), animated: true)
    }
}

//MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userList[0].login == emptyCellMessage {
            if let cell: EmptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellReuseIdentifier) as? EmptyCell {
                tableView.separatorStyle = .none
                return cell
            }
        }

        if let cell: UserListCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserListCell {
            cell.setupCell(text: userList[indexPath.row].login)
            return cell
        }
        return UITableViewCell()
    }
}

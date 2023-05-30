//
//  UserListViewController.swift
//  Github
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit

class UserListViewController: BaseViewController {

    //MARK: - Private variables
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView()

    private let cellReuseIdentifier = "userListCell"
    private let emptyCellReuseIdentifier = "EmptyCell"
    private let viewModel: UserListViewModelType
    private let refreshControl = UIRefreshControl()

    private var userList: [UserResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }

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
        bindViewModel()
        prepareTableView()
        fetchData()
    }

    //MARK: - Private Methods
    func bindViewModel() {
        viewModel.output.onUserListFetched
            .drive(onNext: { [weak self] userListResponse in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
                self.userList = userListResponse
                if userListResponse.isEmpty {
                    self.userList = [UserResponse(login: L10n.Common.TableView.emptyDataMessage, id: 0, avatar_url: "")]
                    return
                }
                self.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.output.isLoading
            .drive(isLoading)
            .disposed(by: disposeBag)

        viewModel.output.error
            .drive(error)
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                if self.userList.isEmpty {
                    self.userList = [UserResponse(login: L10n.Common.TableView.emptyDataMessage, id: 0, avatar_url: "")]
                }
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }

    private func fetchData() {
        viewModel.input.fetchUserList.onNext(())
    }

    private func prepareViews() {
        view.addSubview(contentView)
        navigationItem.title = L10n.UserList.NavigationItem.title
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
        tableView.rowHeight = Constants.Size.medium

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.input.fetchUserList.onNext(())
    }
}

//MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            UserDetailsBuilder().build(userLogin: userList[indexPath.row].login), animated: true
        )
    }

}

//MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userList[0].login == L10n.Common.TableView.emptyDataMessage {
            if let cell: EmptyCell = tableView.dequeueReusableCell(
                withIdentifier: emptyCellReuseIdentifier
            ) as? EmptyCell {
                tableView.separatorStyle = .none
                return cell
            }
        }

        if let cell: UserListCell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdentifier
        ) as? UserListCell {
            cell.setupCell(user: userList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

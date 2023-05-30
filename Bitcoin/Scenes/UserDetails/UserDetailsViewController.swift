//
//  UserDetailsViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit
import RxSwift

class UserDetailsViewController: UIViewController {

    //MARK: - Private variables
    private let contentView = UIView()
    private let tableView = UITableView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()

    private let cellReuseIdentifier = "userDetailsRepositoriesCell"
    private let emptyCellReuseIdentifier = "EmptyCell"

    private let viewModel: UserDetailsViewModelType
    private let disposeBag = DisposeBag()

    private var userDetails: UserDetailsResponse? {
        didSet {
            nameLabel.text = L10n.UserDetails.nameLabel(userDetails?.login ?? "")
            companyLabel.text = L10n.UserDetails.companyLabel(userDetails?.company ?? "")
            locationLabel.text = L10n.UserDetails.locationLabel(userDetails?.location ?? "")
        }
    }
    private var userRepositories: [UserRepositoriesResponse] = []
    private var userLogin: String?

    //MARK: - Initialization
    init(withViewModel viewModel: UserDetailsViewModelType, userLogin: String) {
        self.viewModel = viewModel
        self.userLogin = userLogin
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
        viewModel.output.onUserDetailsFetched
            .drive(onNext: { [weak self] userDetails in
                guard let self = self else { return }
                self.userDetails = userDetails
            }).disposed(by: disposeBag)

        viewModel.output.onUserRepositoriesFetched
            .drive(onNext: { [weak self] userRepositories in
                guard let self = self else { return }
                self.userRepositories = userRepositories
                tableView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func fetchData() {
        if let userLogin = userLogin {
            viewModel.input.fetchUserDetails.onNext(userLogin)
            viewModel.input.fetchUserRepositories.onNext(userLogin)
        }
    }

    private func prepareViews() {
        view.addSubview(contentView)
        navigationItem.title = L10n.UserDetails.NavigationItem.title
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(tableView)

        contentView.backgroundColor = Constants.Color.topBackground

        tableView.backgroundColor = .white

        imageView.image = Constants.Image.logoGitHub
    }

    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive.toggle()
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive.toggle()
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive.toggle()
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive.toggle()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Size.xBig).isActive.toggle()
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Size.medium).isActive.toggle()
        imageView.widthAnchor.constraint(equalToConstant: Constants.Size.big).isActive.toggle()
        imageView.heightAnchor.constraint(equalToConstant: Constants.Size.big).isActive.toggle()

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Size.xBig).isActive.toggle()
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Size.medium).isActive.toggle()

        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.Size.small).isActive.toggle()
        companyLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Size.medium).isActive.toggle()

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: Constants.Size.small).isActive.toggle()
        locationLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Size.medium).isActive.toggle()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.Size.medium).isActive.toggle()
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive.toggle()
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive.toggle()
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive.toggle()

    }

    private func prepareTableView() {
        tableView.register(UserDetailsRepositoriesCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: emptyCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate
extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}

//MARK: - UITableViewDataSource
extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositories"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userRepositories[0].name == L10n.Common.TableView.emptyDataMessage {
            if let cell: EmptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellReuseIdentifier) as? EmptyCell {
                tableView.separatorStyle = .none
                return cell
            }
        }

        if let cell: UserDetailsRepositoriesCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserDetailsRepositoriesCell {
            cell.setupCell(repository: userRepositories[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }
}


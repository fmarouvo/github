//
//  UserDetailsViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit
import RxSwift
import Kingfisher

class UserDetailsViewController: BaseViewController {

    //MARK: - Private variables
    private let contentView = UIView()
    private let tableView = UITableView()
    private let nameLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()
    private let imageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.logoGitHub
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let cellReuseIdentifier = "userDetailsRepositoriesCell"
    private let emptyCellReuseIdentifier = "EmptyCell"

    private let viewModel: UserDetailsViewModelType

    private var userDetails: UserDetailsResponse? {
        didSet {
            nameLabel.text = L10n.UserDetails.nameLabel(userDetails?.login ?? "")
            companyLabel.text = L10n.UserDetails.companyLabel(userDetails?.company ?? "")
            locationLabel.text = L10n.UserDetails.locationLabel(userDetails?.location ?? "")

            if let company = userDetails?.company {
                let companyArray = company.components(separatedBy: ",")
                if let firstCompany = companyArray.first {
                    companyLabel.text = L10n.UserDetails.companyLabel(firstCompany)
                }
                if companyArray.count > 1 {
                    companyLabel.text = "\(companyLabel.text ?? "")"
                }
            }

            if let imageUrl = userDetails?.avatar_url {
                let url = URL(string: imageUrl)
                imageView.kf.setImage(with: url)
            }
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
        bindViewModel()
        prepareTableView()
        fetchData()
    }

    //MARK: - Private Methods
    private func bindViewModel() {
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

        viewModel.output.isLoading
            .drive(isLoading)
            .disposed(by: disposeBag)

        viewModel.output.error
            .drive(error)
            .disposed(by: disposeBag)
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
    }

    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive.toggle()
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive.toggle()
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive.toggle()
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive.toggle()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Size.xBig).isActive.toggle()
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Size.xSmall).isActive.toggle()
        imageView.widthAnchor.constraint(equalToConstant: Constants.Size.big).isActive.toggle()
        imageView.heightAnchor.constraint(equalToConstant: Constants.Size.big).isActive.toggle()

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Size.xBig).isActive.toggle()
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Size.xSmall).isActive.toggle()

        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.Size.xThin).isActive.toggle()
        companyLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Size.xSmall).isActive.toggle()

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: Constants.Size.xThin).isActive.toggle()
        locationLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Size.xSmall).isActive.toggle()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.Size.xSmall).isActive.toggle()
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
        let repository = userRepositories[indexPath.row]
        var message = L10n.UserDetails.repository(repository.name)
        if let description = repository.description {
            message += "\(description)"
        }
        view.displayToast(message)
    }
}

//MARK: - UITableViewDataSource
extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.UserDetails.repositories
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


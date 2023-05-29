//
//  UserDetailsViewController.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit

class UserDetailsViewController: UIViewController {

    //MARK: - Private variables
    private let contentView = UIView()
    private let tableView = UITableView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()

    private let cellReuseIdentifier = "userDetailsRepositoriesCell"

    private let viewModel: UserDetailsViewModelType

    private let repositories = ["Name One", "Name Two", "Name Three", "Name Four", "Name Five", "Name Six", "Name Seven", "Name Eight", "Name Nine", "Name Ten"]

    //MARK: - Initialization
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
        prepareTableView()
    }

    //MARK: - Private Methods
    private func prepareViews() {
        view.addSubview(contentView)
        navigationItem.title = "User Profile"
        nameLabel.text = "User: Name user"
        companyLabel.text = "Company: Company User"
        locationLabel.text = "Location: Location, Lc"
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
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate
extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        navigationController?.pushViewController(UserDetailsBuilder().build(), animated: true)
    }
}

//MARK: - UITableViewDataSource
extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositories"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UserDetailsRepositoriesCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserDetailsRepositoriesCell {
            cell.setupCell(text: repositories[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}


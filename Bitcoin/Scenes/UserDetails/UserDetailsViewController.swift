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
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let nameLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()

    private let cellReuseIdentifier = "userDetailsRepositoriesCell"

    private let viewModel: UserDetailsViewModelType

    private let repositories = ["Name One", "Name Two", "Name Three", "Name Four", "Name Five", "Name Six", "Name Seven", "Name Eight", "Name Nine", "Name Ten"]

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

    private func prepareViews() {
        view.addSubview(contentView)
        navigationItem.title = "User Profile"
        nameLabel.text = "User: Name user"
        companyLabel.text = "Company: Company User"
        locationLabel.text = "Location: Location, Lc"
        titleLabel.text = "Repositories:"
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tableView)

        contentView.backgroundColor = UIColor(rgb: 0xf9f9f9)
        tableView.backgroundColor = .white

        imageView.image = UIImage(named: "logoLaunchScreen")
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

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120).isActive.toggle()
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive.toggle()
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive.toggle()
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive.toggle()

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120).isActive.toggle()
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive.toggle()

        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive.toggle()
        companyLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive.toggle()

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 4).isActive.toggle()
        locationLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive.toggle()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16).isActive.toggle()
        titleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive.toggle()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive.toggle()
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

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        navigationController?.pushViewController(UserDetailsBuilder().build(), animated: true)
    }
}

extension UserDetailsViewController: UITableViewDataSource {
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


//
//  UserDetailsRepositoriesCell.swift
//  Github
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import UIKit

final class UserDetailsRepositoriesCell: UITableViewCell {

    let label = UILabel()
    let watcherImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "watchersIcon")
        return imageView
    }()
    let watchersLabel = UILabel()

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(label)
        addSubview(watcherImageView)
        addSubview(watchersLabel)
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.xSmall).isActive.toggle()
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()

        watcherImageView.translatesAutoresizingMaskIntoConstraints = false

        watchersLabel.translatesAutoresizingMaskIntoConstraints = false
        watchersLabel.trailingAnchor.constraint(equalTo: watcherImageView.leadingAnchor, constant: -Constants.Size.thin).isActive.toggle()
        watchersLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()

        watcherImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.xSmall).isActive.toggle()
        watcherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()
        watcherImageView.widthAnchor.constraint(equalToConstant: Constants.Size.xSmall).isActive.toggle()
        watcherImageView.heightAnchor.constraint(equalToConstant: Constants.Size.xSmall).isActive.toggle()
    }

    func setupCell(repository: UserRepositoriesResponse) {
        backgroundColor = .clear
        label.text = repository.name
        label.textColor = .black

        watchersLabel.text = "\(repository.watchers ?? 0)"
    }
}

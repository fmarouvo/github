//
//  UserListCell.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import UIKit

final class UserListCell: UITableViewCell {

    private let avatarView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.logoGitHub
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.Size.thin
        return imageView
    }()

    private let label = UILabel()

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(avatarView)
        addSubview(label)
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setupConstraints() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.xSmall).isActive.toggle()
        avatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()
        avatarView.widthAnchor.constraint(equalToConstant: Constants.Size.small).isActive.toggle()
        avatarView.heightAnchor.constraint(equalToConstant: Constants.Size.small).isActive.toggle()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.Size.xSmall).isActive.toggle()
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.Size.xSmall).isActive.toggle()
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()
    }

    func setupCell(user: UserResponse) {
        backgroundColor = .clear
        label.text = user.login
        label.textColor = .black
        let url = URL(string: user.avatar_url)
        avatarView.kf.setImage(with: url)
    }
}

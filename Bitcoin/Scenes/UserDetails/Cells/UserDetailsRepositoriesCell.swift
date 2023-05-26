//
//  UserDetailsRepositoriesCell.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import UIKit

final class UserDetailsRepositoriesCell: UITableViewCell {

    let label = UILabel()

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(label)
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive.toggle()
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive.toggle()
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()
    }

    func setupCell(text: String) {
        backgroundColor = .clear
        label.text = text
        label.textColor = .black
    }
}

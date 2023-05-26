//
//  UserListCell.swift
//  Bitcoin
//
//  Created by Fausto Marouvo on 26/05/23.
//

import Foundation
import UIKit

final class UserListCell: UITableViewCell {

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
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive.toggle()
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()
    }

    func setupCell(text: String) {
        backgroundColor = .clear
        label.text = text
    }
}

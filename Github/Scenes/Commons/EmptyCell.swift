//
//  EmptyCell.swift
//  Github
//
//  Created by Fausto Marouvo on 29/05/23.
//

import UIKit

final class EmptyCell: UITableViewCell {

    let label = {
        let label = UILabel()
        label.text = "Data is Empty. Try again later."
        label.textColor = .black
        return label
    }()

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
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive.toggle()
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive.toggle()
    }

    func setupCell(text: String) {
        backgroundColor = .clear
    }
}

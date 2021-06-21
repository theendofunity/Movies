//
//  LoadingTableViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    static let identifier = "LoadingTableViewCell"
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - UISetup

    private func setupLayout() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
}

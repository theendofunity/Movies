//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

// MARK: - Properties

    static let identifier = "SearchTableViewCell"

    let poster = UIImageView()
    let title = UILabel()
    let favorite = UIButton()

    var viewModel: MovieCellViewModelType? {
        didSet {
            guard let viewModel = viewModel,
                  let urlString = viewModel.moviePosterUrl(),
                  let url = URL(string: urlString)
            else { return }
            let placeholder: UIImage? = UIImage(named: "moviePlaceholder")
            poster.kf.indicatorType = .activity
            poster.kf.setImage(with: url, placeholder: placeholder)
            title.text = viewModel.title()
            updateFavoriteButton()
        }
    }

// MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - UISetup

    private func setupLayout() {
        poster.image = UIImage(named: "moviePlaceholder")
        poster.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Some movie"
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false

        favorite.addTarget(self, action: #selector(changeFavoriteState), for: .touchUpInside)

        let stackview = UIStackView(arrangedSubviews: [poster, title, favorite])
        stackview.axis = .horizontal
        stackview.spacing = 20
        stackview.distribution = .fillEqually
        stackview.alignment = .top

        stackview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackview)

        stackview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        stackview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        stackview.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
    }

    @objc private func changeFavoriteState() {
        viewModel?.changeFavoriteState()
        updateFavoriteButton()
    }

    private func updateFavoriteButton() {
        guard let viewModel = viewModel else { return }

        if viewModel.isFavorite() {
            favorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}

//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    
    static let identifier = "SearchTableViewCell"
    
    let poster = UIImageView()
    let title = UILabel()
    
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
        }
    }
    
//    MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK:  - UISetup
    
    private func setupLayout() {
        poster.image = UIImage(named: "moviePlaceholder")
        poster.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Some movie"
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [poster, title])
        stackview.axis = .horizontal
        stackview.spacing = 20
        stackview.distribution = .fillEqually
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackview)
        
        stackview.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackview.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        stackview.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
}

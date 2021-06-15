//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
//    MARK: - Properties
    
    static let identifier = "MovieCollectionViewCell"
    let poster = UIImageView()

    var viewModel: MovieCellViewModelType? {
        willSet {
            guard let newPoster = viewModel?.moviePoster else { return }
            poster.image = newPoster
        }
    }
    
//    MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UISetup
    
    private func setupLayout() {
        poster.image = UIImage(named: "moviePlaceholder")
        poster.translatesAutoresizingMaskIntoConstraints = false

        addSubview(poster)
        
        poster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        poster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

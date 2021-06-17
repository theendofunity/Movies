//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    //    MARK: - Properties
    
    static let identifier = "MovieCollectionViewCell"
    let poster = UIImageView()
    
    var viewModel: MovieCellViewModelType? {
        didSet {
            guard let viewModel = viewModel,
                  let urlString = viewModel.moviePosterUrl(),
                  let url = URL(string: urlString)
            else { return }
            let placeholder: UIImage? = UIImage(named: "moviePlaceholder")
            poster.kf.indicatorType = .activity
            poster.kf.setImage(with: url, placeholder: placeholder)
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
        poster.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(poster)
        
        poster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        poster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

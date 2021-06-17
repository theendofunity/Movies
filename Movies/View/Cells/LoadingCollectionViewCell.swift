//
//  LoadingCollectionViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    static let identifier = "LoadingCollectionViewCell"
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - UISetup
    
    private func setupLayout() {
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
//        layer.backgroundColor = UIColor.blue.cgColor
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.startAnimating()
    }
}

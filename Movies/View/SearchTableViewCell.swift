//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    let poster = UIImageView()
    let title = UILabel()
    
    var viewModel: MovieCellViewModelType? {
        didSet {
            self.updateConfiguration(using: configurationState)
        }
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = self.defaultContentConfiguration().updated(for: state)
                
        content.text = viewModel?.title
                
        if let image = viewModel?.moviePoster  {
            content.image = image
        } else {
            let image = UIImage(named: "moviePlaceholder")
            content.image = image
        }
        
        self.contentConfiguration = content
    }
}

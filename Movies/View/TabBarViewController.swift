//
//  TabBarViewController.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let popularViewModel = MoviesViewModel(type: .popular)
        let topViewModel = MoviesViewModel(type: .top)
        let searchViewModel = MoviesViewModel(type: .search)
        let favoriteViewModel = FavoritesMoviesViewModel()
        
        viewControllers = [
            createTabBarItem(title: "Popular",
                             icon: nil,
                             viewController: CollectionViewController(viewModel: popularViewModel)),
            createTabBarItem(title: "Top",
                             icon: nil,
                             viewController: CollectionViewController(viewModel: topViewModel)),
            createTabBarItem(title: "Search",
                             icon: nil,
                             viewController: SearchViewController(viewModel: searchViewModel)),
            createTabBarItem(title: "Favorite",
                             icon: nil,
                             viewController: FavoritesCollectionViewController(viewModel: favoriteViewModel))
        ]
    }
    
    private func createTabBarItem(title: String,
                                  icon: UIImage?,
                                  viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        tabBarItem.image = icon
        navigationController.tabBarItem = tabBarItem
        
        viewController.title = title
        
        return navigationController
    }
}

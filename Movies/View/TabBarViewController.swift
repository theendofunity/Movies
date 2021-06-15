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
        viewControllers = [
            createTabBarItem(title: "Popular",
                             icon: nil,
                             viewController: CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())),
            createTabBarItem(title: "Top",
                             icon: nil,
                             viewController: CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())),
            createTabBarItem(title: "Search",
                             icon: nil,
                             viewController: SearchViewController())
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

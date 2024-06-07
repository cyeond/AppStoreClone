//
//  TabBarController.swift
//  AppStoreClone
//
//  Created by YD on 6/7/24.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setViewControllers()
    }
    
    private func setupViews() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .background
    }
    
    private func setViewControllers() {
        let homeNavController = UINavigationController()
        let homeViewController = AppsHomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up.fill"), selectedImage: UIImage(systemName: "square.stack.3d.up.fill"))
        homeNavController.setViewControllers([homeViewController], animated: true)
        
        let searchNavController = UINavigationController()
        let searchViewController = SearchHomeViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        searchNavController.setViewControllers([searchViewController], animated: true)
                
        self.setViewControllers([homeNavController, searchNavController], animated: true)
    }
}

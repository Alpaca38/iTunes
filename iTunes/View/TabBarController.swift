//
//  TabBarController.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        
        let saved = UINavigationController(rootViewController: SavedSoftwareViewController())
        saved.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up.fill"), tag: 0)
        
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        setViewControllers([saved, search], animated: true)
    }
}

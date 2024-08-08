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
        
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        setViewControllers([search], animated: true)
    }
}

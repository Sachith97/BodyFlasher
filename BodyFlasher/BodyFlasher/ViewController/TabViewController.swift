//
//  TabViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-22.
//

import UIKit

class TabViewController: UITabBarController {

    var authDetail: LoginResponseDetail = LoginResponseDetail()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupTabs()
        
        self.tabBar.tintColor = UIColor(named: "semi-red")
    }
    
    private func setupTabs() {
        let homeVC = HomeViewController()
        let profileVC = ProfileViewController()
        
        homeVC.authDetail = self.authDetail
        profileVC.authDetail = self.authDetail
        
        let home = createNav(with: "Home", and: UIImage(systemName: "house"), vc: homeVC)
        let profile = createNav(with: "Profile", and: UIImage(systemName: "person"), vc: profileVC)
        
        setViewControllers([home, profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController (rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}

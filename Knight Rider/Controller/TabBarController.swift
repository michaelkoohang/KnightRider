//
//  TabBarController.swift
//  Knight Rider
//
//  Created by Michael on 2/27/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeController = RidesController()
        let createController = CreateController()
        let findController = FindController()
        let profileController = ProfileController()
        let viewControllersList = [homeController, createController, findController, profileController]
        
        self.tabBar.barTintColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 0.5)
        self.tabBar.tintColor = UIColor(red: 99/255, green: 243/255, blue: 147/255, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor.white

        homeController.tabBarItem = UITabBarItem(title: "Your Rides", image: UIImage(named: "home")  , tag: 0)
        createController.tabBarItem = UITabBarItem(title: "Create Rides", image: UIImage(named: "create"), tag: 1)
        findController.tabBarItem = UITabBarItem(title: "Find Rides", image: UIImage(named: "find"), tag: 2)
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        
        viewControllers = viewControllersList.map {
            UINavigationController(rootViewController: $0)
        }
        
    }

}

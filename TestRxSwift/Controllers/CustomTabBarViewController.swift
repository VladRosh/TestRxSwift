//
//  CustomTabBarViewController.swift
//  TestRxSwift
//
//  Created by VLAD on 22/11/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    let tickersVC = TickersViewController()
    let secondVC = SecondViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tickersVC.tabBarItem.title = "Stock tickers"
        secondVC.tabBarItem.title = "Second VC"
        
        tickersVC.tabBarItem.tag = 1
        secondVC.tabBarItem.tag = 2
        
        viewControllers = [tickersVC, secondVC]
    }
    
    // MARK: UITabBarDelegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        tickersVC.isRunning.value = item.tag == 1 ? true : false
    }
}

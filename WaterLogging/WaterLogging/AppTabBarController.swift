//
//  AppTabBarController.swift
//  WaterLogging
//
//

import UIKit

class AppTabBarController: UITabBarController {
    
    let trackWaterViewController = TrackWaterViewController()
    let visualizeWaterIntakeViewController = VisualizeWaterIntakeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let addImage = UIImage(systemName: "plus.circle")
        let vizImage = UIImage(systemName: "chart.bar")
        
        
        trackWaterViewController.tabBarItem = UITabBarItem(title: "Track", image: addImage, tag: 0)
        visualizeWaterIntakeViewController.tabBarItem = UITabBarItem(title: "Visualize", image: vizImage, tag: 1)

        let tabBarList = [trackWaterViewController, visualizeWaterIntakeViewController]

        viewControllers = tabBarList
    }

}

//
//  MainTabBarController.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var missionListVC: MissionListVC!
    private var myMissionVC  : MyMissionVC!
    private var profileVC    : ProfileVC!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewControllers()
    }
    
    private func initializeViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        missionListVC = (storyboard.instantiateViewController(withIdentifier: "MissionList") as! MissionListVC)
        missionListVC.tabBarItem = UITabBarItem(title: "Missions", image: UIImage(named: "list"), selectedImage: UIImage(named: "list"))
        
        myMissionVC = (storyboard.instantiateViewController(withIdentifier: "MyMission") as! MyMissionVC)
        myMissionVC.tabBarItem = UITabBarItem(title: "My Mission", image: UIImage(named: "list"), selectedImage: UIImage(named: "list"))
        
        profileVC = (storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileVC)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "list"), selectedImage: UIImage(named: "list"))
        
        let firstItem  = UINavigationController(rootViewController: missionListVC)
        let secondItem = UINavigationController(rootViewController: myMissionVC)
        let thirdItem  = UINavigationController(rootViewController: profileVC)

        self.viewControllers = [firstItem, secondItem, thirdItem]

        tabBar.isOpaque      = false
        tabBar.isTranslucent = false
        tabBar.tintColor     = UIColor.custom.primary
        tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
    }
    
}



















































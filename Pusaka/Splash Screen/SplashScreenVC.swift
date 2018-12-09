//
//  SplashScreenVC.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UserManager.shared.getUser()
            UserManager.shared.isLoggedIn() ? self.showMain() : self.showAuthorization()
        }
    }
    
    private func showAuthorization() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let landingPage = storyboard.instantiateViewController(withIdentifier: "nav")
        DispatchQueue.main.async { window.rootViewController = landingPage }
    }
    
    private func showMain() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "TabBar")
        DispatchQueue.main.async { window.rootViewController = mainVC }
    }

}

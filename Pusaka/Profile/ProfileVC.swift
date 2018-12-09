//
//  ProfileVC.swift
//  Pusaka
//
//  Created by Steven Bong on 30/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func actionLogOut() {
        UserManager.shared.logout()
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let landingPageVC = storyboard.instantiateViewController(withIdentifier: "nav")
        DispatchQueue.main.async { self.present(landingPageVC, animated: true, completion: nil) }
    }

}

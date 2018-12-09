//
//  LoginVC.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {
    
    @IBOutlet private weak var tf_email   : UITextField!
    @IBOutlet private weak var tf_password: UITextField!
    @IBOutlet private weak var btn_login  : UIButton!
    @IBOutlet private weak var container  : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isHidden     = false
        navigationController?.navigationBar.tintColor    = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.navigationBar.shadowImage  = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func configureView() {
        btn_login.layer.masksToBounds = true
        btn_login.layer.cornerRadius  = btn_login.frame.height / 2
        container.layer.masksToBounds = true
        container.layer.cornerRadius  = 8
    }
    
    @IBAction private func actionLogin() {
        let email    = tf_email.text!
        let password = tf_password.text!
        
        guard !email.isEmpty else {
            return
        }
        guard !password.isEmpty else {
            return
        }
        let pikachu: [String:Any] = ["email": email, "password": password, "lang": "id"]
        let params = ["pikachu": pikachu.toString()]
        Connection.shared.connect(_url: NetworkConst.login, params: params, model: User.self) { [weak self] (error, user) in
            guard let viewController = self else { return }
            guard error == nil else {
                viewController.showAlert(title: "", message: error!.errorMessage)
                return
            }
            guard let user = user else {
                return
            }
            UserManager.shared.saveUser(user: user)
            DispatchQueue.main.async {
                if let window = UIApplication.shared.keyWindow {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBar = storyboard.instantiateViewController(withIdentifier: "TabBar")
                    window.rootViewController = mainTabBar
                }
            }
        }
    }
    
    @IBAction private func actionGoogleLogin() {
        GIDSignIn.sharedInstance().uiDelegate = self
        if(GIDSignIn.sharedInstance().hasAuthInKeychain()){
            GIDSignIn.sharedInstance().signOut()
        } else {
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().signIn()
        }
    }

}


extension LoginVC: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        DispatchQueue.main.async { viewController.present(viewController, animated: true, completion: nil) }
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        DispatchQueue.main.async { viewController.dismiss(animated: true, completion: nil) }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            return
        }
//        let fullName = user.profile.givenName + user.profile.familyName
    }
}

















































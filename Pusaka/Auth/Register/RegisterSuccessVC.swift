//
//  RegisterSuccessVC.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class RegisterSuccessVC: UIViewController {
    
    @IBOutlet private weak var v_gender : UIView!
    @IBOutlet private weak var btn_login: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigation()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func configureView() {
        btn_login.layer.cornerRadius  = btn_login.frame.height / 2
        btn_login.layer.masksToBounds = true
        
        v_gender.layer.masksToBounds = true
        v_gender.layer.cornerRadius  = v_gender.frame.width / 2
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor   = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let customBackButton = UIBarButtonItem(image: UIImage(named: "arrow-back-white") , style: .plain, target: self, action: #selector(actionMain))
            customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton    }
    
    @IBAction private func actionShowMain() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func actionMain() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}





















































//
//  RegisterVC.swift
//  Pusaka
//
//  Created by Steven Bong on 23/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet private weak var v_gender    : UIView!
    @IBOutlet private weak var v_boy_outer : UIView!
    @IBOutlet private weak var v_boy_inner : UIView!
    @IBOutlet private weak var v_girl_outer: UIView!
    @IBOutlet private weak var v_girl_inner: UIView!
    
    @IBOutlet private weak var tf_fullname: UITextField!
    @IBOutlet private weak var tf_school  : UITextField!
    @IBOutlet private weak var tf_account : UITextField!
    @IBOutlet private weak var tf_email   : UITextField!
    @IBOutlet private weak var tf_password: UITextField!
    @IBOutlet private weak var tf_confirm_password: UITextField!
    @IBOutlet private weak var btn_register: UIButton!
    @IBOutlet private weak var btn_login   : UIButton!
    @IBOutlet private weak var container   : UIView!
    
    private var isMale: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigation()
    }
    
    private func configureView() {
        v_gender.layer.masksToBounds  = true
        v_gender.layer.cornerRadius   = v_gender.frame.width / 2
        container.layer.cornerRadius  = 8
        container.layer.masksToBounds = true
        
        v_boy_outer.tag = 1
        v_boy_outer.layer.borderWidth   = 2
        v_boy_outer.layer.borderColor   = UIColor.custom.primary.cgColor
        v_boy_outer.backgroundColor     = UIColor.white
        v_boy_outer.layer.cornerRadius  = v_boy_outer.frame.width / 2
        v_boy_outer.layer.masksToBounds = true
        v_boy_outer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleGender(_:))))
        
        v_boy_inner.backgroundColor     = UIColor.custom.primary
        v_boy_inner.layer.cornerRadius  = v_boy_inner.frame.width / 2
        v_boy_inner.layer.masksToBounds = true
        
        v_girl_outer.tag = 2
        v_girl_outer.layer.borderWidth   = 1
        v_girl_outer.layer.borderColor   = UIColor.lightGray.cgColor
        v_girl_outer.backgroundColor     = UIColor.white
        v_girl_outer.layer.cornerRadius  = v_girl_outer.frame.width / 2
        v_girl_outer.layer.masksToBounds = true
        v_girl_outer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleGender(_:))))
        
        v_girl_inner.layer.cornerRadius  = v_boy_inner.frame.width / 2
        v_girl_inner.layer.masksToBounds = true
        
        btn_register.layer.cornerRadius  = btn_register.frame.height / 2
        btn_register.layer.masksToBounds = true
    }
    
    private func configureNavigation() {
        title = "Daftar Akun"
        navigationController?.navigationBar.isHidden     = false
        navigationController?.navigationBar.tintColor    = UIColor.custom.primary
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage  = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontBook.bold.large(),
            NSAttributedString.Key.foregroundColor: UIColor.custom.primary
        ]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func toggleGender(_ sender: UITapGestureRecognizer) {
        guard let senderView = sender.view else { return }
        DispatchQueue.main.async { self.toggleGenderButton(isMale: senderView.tag == self.v_boy_outer.tag) }
    }
    
    private func toggleGenderButton(isMale: Bool) {
        self.isMale = isMale
        v_boy_outer.layer.borderWidth   = isMale ? 2 : 1
        v_boy_outer.layer.borderColor   = isMale ? UIColor.lightGray.cgColor : UIColor.custom.primary.cgColor
        v_boy_inner.backgroundColor     = isMale ? UIColor.custom.primary : UIColor.white
        
        v_girl_outer.layer.borderWidth  = isMale ? 1 : 2
        v_girl_outer.layer.borderColor  = isMale ? UIColor.lightGray.cgColor : UIColor.custom.primary.cgColor
        v_girl_inner.backgroundColor    = isMale ? UIColor.white : UIColor.custom.primary
    }
    
    @IBAction private func actionRegister(_ sender: UIButton) {
        var pikachu: [String: Any] = [:]
            pikachu["email"]      = tf_email.text!
            pikachu["password"]   = tf_password.text!
            pikachu["userName"]   = tf_account.text!
            pikachu["fullName"]   = tf_fullname.text!
            pikachu["cardNumber"] = "388744848484"
            pikachu["cardType"]   = "1"
            pikachu["cardImage"]  = "woahhh.jpg"
            pikachu["lang"]       = "id"
        let params: [String: Any] = ["pikachu": pikachu.toString()]
        Connection.shared.connect(_url: NetworkConst.signup, params: params, model: Register.self) { [weak self] (error, response) in
            guard let viewController = self else { return }
            guard error == nil else {
                viewController.showAlert(title: "Error [\(error!.errorCode)]", message: error!.errorMessage)
                return
            }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
                let registerSuccessVC = storyboard.instantiateViewController(withIdentifier: "RegisterSuccess") as! RegisterSuccessVC
                DispatchQueue.main.async { viewController.navigationController?.pushViewController(registerSuccessVC, animated: true) }
            }
        }
    }
    
    @IBAction private func actionLogin(_ sender: UIButton) {
        
    }
    
}






































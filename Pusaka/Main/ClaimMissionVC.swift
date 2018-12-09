//
//  ClaimMissionVC.swift
//  Pusaka
//
//  Created by Steven Bong on 25/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

struct EmptyStruct: Decodable {}

protocol ClaimMissionDelegate: class {
    func missionClaimed()
}

class ClaimMissionVC: UIViewController {
    
    @IBOutlet private weak var v_border : UIView!
    @IBOutlet private weak var v_shadow : UIView!
    @IBOutlet private weak var btn_no   : UIButton!
    @IBOutlet private weak var btn_yes  : UIButton!
    
    weak var delegate: ClaimMissionDelegate?
    var missionID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        btn_yes.layer.cornerRadius  = btn_yes.frame.height / 2
        btn_yes.layer.masksToBounds = true
        
        v_border.layer.cornerRadius = 8
        v_border.layer.masksToBounds = true
        
        v_shadow.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        v_shadow.layer.shadowOffset  = CGSize(width: 0, height: 3)
        v_shadow.layer.shadowOpacity = 1
        v_shadow.layer.shadowRadius  = 10
        v_shadow.layer.masksToBounds = false
        v_shadow.backgroundColor     = UIColor.clear
    }
    
    @IBAction private func actionNo() {
        DispatchQueue.main.async { self.dismiss(animated: true, completion: nil) }
    }
    
    @IBAction private func actionYes() {
        let pikachu: [String:Any] = ["missionID": missionID, "userID": UserManager.shared.userID, "lang": "id"]
        let params = ["pikachu": pikachu.toString()]
        Connection.shared.connect(_url: NetworkConst.mission_take, params: params, model: EmptyStruct.self) { [weak self] (error, result) in
            guard let viewController = self else { return }
            guard error == nil else {
                viewController.showAlert(title: "", message: error!.errorMessage)
                return
            }
            viewController.delegate?.missionClaimed()
            DispatchQueue.main.async { viewController.dismiss(animated: true, completion: nil) }
        }
    }
    
}

























































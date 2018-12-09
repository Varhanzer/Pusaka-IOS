//
//  MissionListProfileCell.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class MissionListProfileCell: UITableViewCell {
    
    @IBOutlet weak var iv_user        : UIImageView!
    @IBOutlet weak var v_user         : UIView!
    @IBOutlet weak var v_shadow       : UIView!
    @IBOutlet weak var v_border       : UIView!
    @IBOutlet weak var lb_nickname    : UILabel!
    @IBOutlet weak var lb_fullname    : UILabel!
    @IBOutlet weak var lb_school      : UILabel!
    @IBOutlet weak var lb_point       : UILabel!
    @IBOutlet weak var lb_next_mission: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        v_user.layer.cornerRadius  = v_user.frame.width / 2
        v_user.layer.masksToBounds = true
        
        v_border.layer.cornerRadius = 8
        v_border.layer.masksToBounds = true
        
        v_shadow.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        v_shadow.layer.shadowOffset  = CGSize(width: 0, height: 3)
        v_shadow.layer.shadowOpacity = 1
        v_shadow.layer.shadowRadius  = 10
        v_shadow.layer.masksToBounds = false
        v_shadow.backgroundColor     = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}






















































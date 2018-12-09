//
//  MyMissionCompletedCell.swift
//  Pusaka
//
//  Created by Steven Bong on 29/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class MyMissionCompletedCell: UITableViewCell {
    
    @IBOutlet weak var lb_mission_name     : UILabel!
    @IBOutlet weak var lb_mission_organizer: UILabel!
    @IBOutlet weak var lb_completed_date   : UILabel!
    @IBOutlet weak var lb_mission_point    : UILabel!
    @IBOutlet weak var container_point     : UIView!
    @IBOutlet weak var container_shadow    : UIView!
    @IBOutlet weak var iv_star             : UIImageView!
    @IBOutlet weak var iv_mission          : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        container_point.layer.cornerRadius   = container_point.frame.height / 2
        container_point.layer.masksToBounds  = true
        container_point.layer.shadowColor    = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        container_shadow.layer.shadowOffset  = CGSize(width: 0.0, height: 3.0)
        container_shadow.layer.shadowOpacity = 0.3
        container_shadow.layer.shadowRadius  = 5
        container_shadow.layer.masksToBounds = false
        container_shadow.backgroundColor     = UIColor.clear
        iv_mission.layer.cornerRadius  = iv_mission.frame.width / 2
        iv_mission.layer.masksToBounds = true
        iv_mission.layer.borderWidth   = 1
        iv_mission.layer.borderColor   = UIColor.darkGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//
//  MyMissionOnGoingCell.swift
//  Pusaka
//
//  Created by Steven Bong on 29/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class MyMissionOnGoingCell: UITableViewCell {
    
    @IBOutlet weak var iv_mission           : UIImageView!
    @IBOutlet weak var lb_mission_organizer : UILabel!
    @IBOutlet weak var lb_mission_name      : UILabel!
    @IBOutlet weak var lb_mission_date      : UILabel!
    @IBOutlet weak var lb_mission_point     : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        iv_mission.layer.cornerRadius  = 8
        iv_mission.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

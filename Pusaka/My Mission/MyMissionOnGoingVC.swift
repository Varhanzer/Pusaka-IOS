//
//  MyMissionOnGoingVC.swift
//  Pusaka
//
//  Created by Steven Bong on 29/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyMissionOnGoingVC: UIViewController, IndicatorInfoProvider  {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var onGoingMissionList: [OnGoingMission] = []
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BERLANGSUNG")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getMissionList()
    }
    
    private func configureView() {
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableFooterView = UIView()
    }
    
    private func getMissionList() {
        let pikachu: [String: Any] = ["userID": UserManager.shared.userID, "lang":"id"]
        let params = ["pikachu": pikachu.toString()]
        Connection.shared.connect(_url: NetworkConst.mission_ongoing, params: params, model: [OnGoingMission].self) { [unowned self] (error, response) in
            guard error == nil else {
                self.showAlert(title: "Error [\(error!.errorCode)]", message: error!.errorMessage)
                return
            }
            guard let onGoingMissionList = response else {
                return
            }
            self.onGoingMissionList = onGoingMissionList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension MyMissionOnGoingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onGoingMissionList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mission = onGoingMissionList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyMissionOnGoingCell
            cell.selectionStyle = .none
            cell.lb_mission_organizer.text = mission.orgName
            cell.lb_mission_name.text      = mission.misName
            cell.lb_mission_point.text     = mission.pointValue
        return cell
    }
}
























































































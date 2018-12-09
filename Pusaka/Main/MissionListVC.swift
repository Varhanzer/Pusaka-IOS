//
//  MissionListVC.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class MissionListVC: UIViewController {
    
    fileprivate let greyTextAttribute   = [NSAttributedString.Key.font: FontBook.standard.regular(),
                                           NSAttributedString.Key.foregroundColor: UIColor.lightGray]
    fileprivate let orangeTextAttribute = [NSAttributedString.Key.font: FontBook.standard.regular(),
                                           NSAttributedString.Key.foregroundColor: UIColor.custom.orange]
    fileprivate let boldTextAttribute   = [NSAttributedString.Key.font: FontBook.bold.regular(),
                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    
    @IBOutlet private var tableView: UITableView!
    
    private var loadingView: LoadingView?
    private var missionList: MissionList?
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            formatter.locale     = NSLocale.current
        return formatter
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        getMissionList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.view.backgroundColor = UIColor.custom.primary
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigation()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.custom.primary
        navigationController?.navigationBar.backgroundColor = UIColor.custom.primary
    }
    
    private func configureView() {
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableFooterView = UIView()
        tableView.separatorInset  = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        tableView.contentInset    = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    }
    
    private func configureNavigation() {
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.custom.primary
        navigationController?.navigationBar.isTranslucent = true
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 20))
        let image = UIImage(named: "ic-pusaka")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
        let notificationContainer = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let notificationImage = UIImage(named: "notification")
        let notificationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            notificationImageView.contentMode = .scaleAspectFit
            notificationImageView.image = notificationImage
        notificationContainer.addSubview(notificationImageView)
        let notificationBarButton = UIBarButtonItem(customView: notificationContainer)
        navigationItem.rightBarButtonItem = notificationBarButton
        navigationItem.backBarButtonItem  = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func getParticipant(mission: Mission) -> NSAttributedString {
        let applicant    = Int(mission.applicants) ?? 0
        let maxApplicant = Int(mission.maxParticipant) ?? 0
        let remainingParticipant = maxApplicant - applicant
        if remainingParticipant < 10 {
            let attributedString = NSMutableAttributedString(string: "Sisa", attributes: greyTextAttribute)
                attributedString.append(NSAttributedString(string: " \(remainingParticipant) partisipan", attributes: orangeTextAttribute))
            return attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: "\(applicant)", attributes: boldTextAttribute)
                attributedString.append(NSAttributedString(string: " dari \(remainingParticipant) partisipan", attributes: greyTextAttribute))
            return attributedString
        }
    }
    
    private func showLoading() {
        loadingView = LoadingView(viewController: self)
        loadingView?.show()
    }

}

extension MissionListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (missionList == nil ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : missionList?.listContent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profile") as! MissionListProfileCell
                cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mission") as! MissionListMissionCell
                cell.selectionStyle = .none
            guard let mission = missionList?.listContent[indexPath.row] else { return cell }
                cell.lb_mission_name.text  = mission.misName
                cell.lb_mission_point.text = mission.point
                cell.lb_mission_date.text  = dateFormatter.string(from: dateFormatter.date(from: mission.dayStart) ?? Date())
            cell.lb_mission_participant.attributedText = getParticipant(mission: mission)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "header")
        return section == 0 ? nil : headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let missionList = self.missionList, indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let missionDetail = storyboard.instantiateViewController(withIdentifier: "MissionDetail") as! MissionDetailVC
                missionDetail.missionID = missionList.listContent[indexPath.row].missionID
            DispatchQueue.main.async { self.navigationController?.pushViewController(missionDetail, animated: true) }
        }
    }
}

private extension MissionListVC {
    func getMissionList() {
        DispatchQueue.main.async { self.showLoading() }
        let pikachu: [String:Any] = ["lang": "id", "userID": UserManager.shared.userID]
        let params = ["pikachu": pikachu.toString()]
        Connection.shared.connect(_url: NetworkConst.mission_list, params: params, model: MissionList.self) { [weak self] (error, missionList) in
            guard let viewController = self else { return }
            DispatchQueue.main.async { viewController.loadingView?.hide() }
            guard error == nil else {
                viewController.showAlert(title: "Error [\(error!.errorCode)]", message: error!.errorMessage)
                return
            }
            viewController.missionList = missionList
            DispatchQueue.main.async { viewController.tableView.reloadData() }
        }
    }
}














































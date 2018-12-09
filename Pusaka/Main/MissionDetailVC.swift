//
//  MissionDetailVC.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class MissionDetailVC: UIViewController {
    
    @IBOutlet private var bulletList: [UIView]!
    
    @IBOutlet private weak var scrollView             : UIScrollView!
    @IBOutlet private weak var lb_mission_org         : UILabel!
    @IBOutlet private weak var lb_mission_name        : UILabel!
    @IBOutlet private weak var lb_mission_point       : UILabel!
    @IBOutlet private weak var lb_mission_participant : UILabel!
    @IBOutlet private weak var lb_mission_duration    : UILabel!
    @IBOutlet private weak var lb_mission_start_date  : UILabel!
    @IBOutlet private weak var lb_mission_location    : UILabel!
    @IBOutlet private weak var lb_mission_desc        : UILabel!
    @IBOutlet private weak var lb_mission_address     : UILabel!
    @IBOutlet private weak var btn_take_mission       : UIButton!
    @IBOutlet private weak var v_mission_point_shadow : UIView!
    @IBOutlet private weak var v_mission_point_border : UIView!
    @IBOutlet private weak var googleMap: GMSMapView!
    
    private var loadingView  : LoadingView?
    private var iv_mission   : UIImageView!
    private var missionDetail: MissionDetail?
    var missionID: String!
    
    private let missionImageHeight: CGFloat = 240
    private lazy var minimumHeight: CGFloat = {
        let navigationHeight = navigationController?.navigationBar.frame.size.height ?? 0.0
        let statusbarHeight = UIApplication.shared.statusBarView?.frame.size.height ?? 0.0
        return navigationHeight + statusbarHeight
    }()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
            formatter.locale     = NSLocale.current
        return formatter
    }()
    private lazy var startDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
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
        getMissionDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.shadowImage     = UIImage()
        navigationController?.view.backgroundColor          = UIColor.clear
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent   = true
        navigationController?.navigationBar.barTintColor    = UIColor.clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func getMissionDetail() {
        DispatchQueue.main.async { self.showLoading() }
        let pikachu: [String:Any] = ["missionID": missionID, "userID": UserManager.shared.userID, "lang": "id"]
        let params = ["pikachu": pikachu.toString()]
        Connection.shared.connect(_url: NetworkConst.mission_get, params: params, model: MissionDetail.self) { [weak self] (error, missionDetail) in
            guard let viewController = self else { return }
            DispatchQueue.main.async { viewController.loadingView?.hide() }
            guard let missionDetail = missionDetail, error == nil else {
                return
            }
            viewController.missionDetail = missionDetail
            DispatchQueue.main.async { viewController.updateUI() }
        }
    }
    
    private func updateUI() {
        guard let missionDetail = self.missionDetail else { return }
        lb_mission_org.text   = missionDetail.orgName
        lb_mission_name.text  = missionDetail.misName
        lb_mission_point.text = missionDetail.pointValue
        
        let participantAttribute        = [NSAttributedString.Key.font: FontBook.standard.regular(), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let currentParticipantAttribute = [NSAttributedString.Key.font: FontBook.bold.regular(), NSAttributedString.Key.foregroundColor: UIColor.custom.primary]
        let participantAttributedString = NSMutableAttributedString(string: "\(missionDetail.applicants)", attributes: currentParticipantAttribute)
            participantAttributedString.append(NSAttributedString(string: "/\(missionDetail.maxParticipant) partisipan", attributes: participantAttribute))
        lb_mission_participant.attributedText = participantAttributedString
        lb_mission_duration.text   = getMissionDuration()
        lb_mission_start_date.text = startDateFormatter.string(from: dateFormatter.date(from: missionDetail.dayStart)!)
        lb_mission_location.text   = missionDetail.misPlace
        lb_mission_desc.text       = missionDetail.misDesc
        lb_mission_address.text    = missionDetail.misAddress
        
        btn_take_mission.setTitle(missionDetail.missionStatus == "0" ? "Ambil Misi" : "Absen", for: .normal)
        btn_take_mission.backgroundColor = missionDetail.missionStatus == "0" ? UIColor.custom.lightBlue : UIColor.lightGray
        
        let camera = GMSCameraPosition.camera(withLatitude: missionDetail.latitude, longitude: missionDetail.longitude, zoom: 12, bearing: 0, viewingAngle: 75)
        googleMap.animate(to: camera)
        googleMap.clear()
        
        let marker = GMSMarker()
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = googleMap
        marker.position = CLLocationCoordinate2D(latitude: missionDetail.latitude, longitude: missionDetail.longitude)
    }
    
    private func getMissionDuration() -> String {
        guard let missionDetail = self.missionDetail else { return "-" }
        let _startDate = dateFormatter.date(from: missionDetail.dayStart)
        let _endDate   = dateFormatter.date(from: missionDetail.dayEnd)
        guard let startDate = _startDate, let endDate = _endDate else { return "-" }
        let timeDifference = Calendar.current.dateComponents([.hour], from: startDate, to: endDate)
        return "\(timeDifference.hour ?? 0) Jam"
    }
    
    @IBAction private func actionTakeMission() {
        guard let missionDetail = self.missionDetail else { return }
        if missionDetail.missionStatus == "1" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let claimMission = storyboard.instantiateViewController(withIdentifier: "ClaimMission") as! ClaimMissionVC
            claimMission.modalTransitionStyle   = .crossDissolve
            claimMission.modalPresentationStyle = .overCurrentContext
            claimMission.delegate  = self
            claimMission.missionID = missionID
            DispatchQueue.main.async { self.navigationController?.present(claimMission, animated: true, completion: nil) }
        } else if missionDetail.missionStatus == "2" {
            
        }
    }
    
    private func showLoading() {
        loadingView = LoadingView(viewController: self)
        loadingView?.show()
    }
    
}

extension MissionDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = (missionImageHeight) - (scrollView.contentOffset.y - 31 - minimumHeight + (missionImageHeight))
        let height = min(max(y, minimumHeight), 1000)
        iv_mission.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
}

extension MissionDetailVC: ClaimMissionDelegate {
    func missionClaimed() {
        getMissionDetail()
    }
}

private extension MissionDetailVC {
    private func configureView() {
        for bullet in bulletList {
            bullet.layer.cornerRadius  = bullet.frame.width / 2
            bullet.layer.masksToBounds = true
        }
        btn_take_mission.layer.cornerRadius  = btn_take_mission.frame.height / 2
        btn_take_mission.layer.masksToBounds = true
        
        googleMap.settings.setAllGesturesEnabled(false)

        v_mission_point_border.layer.cornerRadius = v_mission_point_border.frame.height / 2
        v_mission_point_border.layer.masksToBounds = true
        
        v_mission_point_shadow.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        v_mission_point_shadow.layer.shadowOffset  = CGSize(width: 0, height: 3)
        v_mission_point_shadow.layer.shadowOpacity = 1
        v_mission_point_shadow.layer.shadowRadius  = 10
        v_mission_point_shadow.layer.masksToBounds = false
        v_mission_point_shadow.backgroundColor     = UIColor.clear
        
        iv_mission = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: missionImageHeight))
        iv_mission.image = UIImage(named: "paris")
        iv_mission.contentMode = .scaleAspectFill
        iv_mission.clipsToBounds = true
        view.addSubview(iv_mission)
        view.sendSubviewToBack(iv_mission)
        
        scrollView.delegate = self
        scrollView.contentInset = UIEdgeInsets(top: missionImageHeight - 31 - minimumHeight, left: 0, bottom: 0, right: 0)
    }
}




















































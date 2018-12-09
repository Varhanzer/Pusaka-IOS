//
//  MyMissionVC.swift
//  Pusaka
//
//  Created by Steven Bong on 29/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyMissionVC: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var container_ongoing: UIView!
    @IBOutlet private weak var container_done   : UIView!
    
    private var onGoingVC  : MyMissionOnGoingVC!
    private var completedVC: MyMissionCompletedVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigation()
    }
    
    private func configureView() {
        scrollView.delegate = self
        container_done.layer.cornerRadius     = container_done.frame.height / 2
        container_done.layer.masksToBounds    = true
        container_done.backgroundColor        = UIColor.clear
        container_done.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionShowCompletedMission)))
        container_ongoing.layer.cornerRadius  = container_ongoing.frame.height / 2
        container_ongoing.layer.masksToBounds = true
        container_ongoing.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionShowOnGoingMission)))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        onGoingVC = (storyboard.instantiateViewController(withIdentifier: "ongoing") as! MyMissionOnGoingVC)
        onGoingVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: scrollView.frame.height)
        onGoingVC.willMove(toParent: self)
        addChild(onGoingVC)
        onGoingVC.didMove(toParent: self)
        scrollView.addSubview(onGoingVC.view)
        
        completedVC = (storyboard.instantiateViewController(withIdentifier: "completed") as! MyMissionCompletedVC)
        completedVC.view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        completedVC.willMove(toParent: self)
        addChild(completedVC)
        completedVC.didMove(toParent: self)
        scrollView.addSubview(completedVC.view)
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height)
    }
    
    private func configureNavigation() {
        title = "Misi Saya"
        navigationController?.navigationBar.tintColor     = UIColor.white
        navigationController?.navigationBar.barTintColor  = UIColor.custom.primary
        navigationController?.navigationBar.shadowImage   = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontBook.medium.large(),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    @objc private func actionShowOnGoingMission() {
        scrollView.scrollRectToVisible(onGoingVC.view.frame, animated: true)
    }
    
    @objc private func actionShowCompletedMission() {
        scrollView.scrollRectToVisible(completedVC.view.frame, animated: true)
    }
    
}

extension MyMissionVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.width
        container_done.backgroundColor    = currentPage > 0.5 ? UIColor.custom.lightViolet : UIColor.clear
        container_ongoing.backgroundColor = currentPage > 0.5 ? UIColor.clear : UIColor.custom.lightViolet
    }
}

//
//  LandingPageVC.swift
//  Pusaka
//
//  Created by Steven Bong on 19/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class LandingPageVC: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl   : UIPageControl!
    @IBOutlet private weak var btn_register  : UIButton!
    @IBOutlet private weak var btn_login     : UIButton!
    
    private let imageList: [UIImage?] = [
        UIImage(named: "onboarding1"),
        UIImage(named: "onboarding2"),
        UIImage(named: "onboarding3"),
        UIImage(named: "onboarding4")
    ]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let value = (view.frame.size.width - (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        var insets = collectionView.contentInset
            insets.left  = value
            insets.right = value
        collectionView.contentInset = insets
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let value = (view.frame.size.width - (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        var insets = collectionView.contentInset
            insets.left  = value
            insets.right = value
        collectionView.contentInset = insets
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    private func configureView() {
        collectionView.delegate   = self
        collectionView.dataSource = self
        
        pageControl.numberOfPages = imageList.count
        
        btn_register.layer.cornerRadius  = btn_register.frame.height / 2
        btn_register.layer.masksToBounds = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction private func actionRegister() {
        
    }

}

extension LandingPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / (view.frame.width * 0.75) + 0.5)
        var color: UIColor {
            switch currentPage {
            case 0: return UIColor.custom.pink
            case 1: return UIColor.custom.lightBlue
            case 2: return UIColor.custom.magenta
            default: return UIColor.custom.orange
            }
        }
        DispatchQueue.main.async {
            self.pageControl.currentPage = currentPage
            self.pageControl.currentPageIndicatorTintColor = color
            self.btn_register.backgroundColor = color
            self.btn_login.setTitleColor(color, for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LandingPageCell
            cell.imageView.image = imageList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionView.frame.size
        return CGSize(width: collectionView.frame.width * 0.75, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

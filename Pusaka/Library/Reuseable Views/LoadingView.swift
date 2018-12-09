//
//  LoadingView.swift
//  Ezeelink
//
//  Created by  Steven Bong on 19/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var container_shadow: UIView!
    @IBOutlet weak var container_border: UIView!
    @IBOutlet weak var lb_text  : UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private weak var targetViewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(viewController: UIViewController? = nil) {
        if let vc = viewController {
            self.init(frame: vc.view.frame)
            self.targetViewController = vc
        } else {
            self.init(frame: UIApplication.shared.keyWindow?.frame ?? CGRect.zero )
        }
        initalizeView()
    }
    
    private func initalizeView() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        rootView.frame = bounds
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(rootView)
        configureView()
    }
    
    private func configureView() {
        container_border.layer.cornerRadius  = 8
        container_border.layer.masksToBounds = true
        container_border.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        container_shadow.layer.shadowOffset  = CGSize(width: 0.0, height: 3.0)
        container_shadow.layer.shadowOpacity = 0.5
        container_shadow.layer.shadowRadius  = 10
        container_shadow.layer.masksToBounds = false
        container_shadow.backgroundColor     = UIColor.clear
    }
    
    func show() {
        rootView.alpha = 0
        if let vc = self.targetViewController {
            rootView.alpha = 0
            vc.view.addSubview(rootView)
            activityIndicator.startAnimating()
        } else {
            guard let window = UIApplication.shared.keyWindow else { return }
            window.addSubview(rootView)
            activityIndicator.startAnimating()
        }
        UIView.animate(withDuration: 0.5) { self.rootView.alpha = 1 }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, animations: { self.rootView.alpha = 0 }) { (completed) in self.rootView.removeFromSuperview() }
    }
    
    
}







































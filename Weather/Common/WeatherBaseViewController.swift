//
//  WeatherBaseViewController.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

class WeatherBaseViewController: UIViewController {
    
    var activityView: UIActivityIndicatorView?
    
    lazy var errorViewController = ErrorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension WeatherBaseViewController: RetryDelegate {
    
    @objc func onRetryTap() {}
    
    func showErrorView(with errorTitle: String) {
        errorViewController.configureView(with: errorTitle)
        self.addChild(errorViewController)
        self.errorViewController.view.frame = view.bounds
        self.view.addSubview(errorViewController.view)
        self.view.bringSubviewToFront(errorViewController.view)
        self.errorViewController.didMove(toParent: self)
    }
    
    func hideErrorView() {
        self.errorViewController.willMove(toParent: nil)
        self.errorViewController.view.removeFromSuperview()
        self.errorViewController.removeFromParent()
    }
}

extension WeatherBaseViewController {
    
    func showActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            activityView = UIActivityIndicatorView(style:  UIActivityIndicatorView.Style.gray)
        }
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
        self.view.isUserInteractionEnabled = false
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}

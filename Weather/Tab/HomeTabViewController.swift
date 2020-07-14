//
//  HomeTabViewController.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit
import SwiftUI

class HomeTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let uiKitFlow = setupSwiftUIKitViews()
        uiKitFlow.tabBarItem = UITabBarItem(title: "Swift",
                                            image: UIImage(named: "uikit"),
                                            tag: 0)
        
        
        let swiftUIFlow = setupSwiftUIViews()
        swiftUIFlow.tabBarItem = UITabBarItem(title: "SwiftUI",
                                              image: UIImage(named: "swiftui"),
                                              tag: 1)
        
        
        let objectiveCFlow = setupObjectiveCViews()
        objectiveCFlow.tabBarItem = UITabBarItem(title: "Objective C",
                                                 image: UIImage(named: "objectivec"),
                                                 tag: 2)
        
        self.viewControllers = [uiKitFlow, swiftUIFlow, objectiveCFlow]
    }
    
    func setupSwiftUIViews() -> UIViewController {
        
        var swiftUIFlow : UIViewController!
        
        if #available(iOS 13.0.0, *) {
            
            let interactorDependencies = WeatherDetailInteractorDependencies()
            let interactor = WeatherDetailInteractor(dependencies: interactorDependencies)
            let presenter = WeatherForecastPresenter(interactor: interactor)
            
            let contentView = HomeView(presenter: presenter)
            swiftUIFlow = UIHostingController(rootView: contentView)
        } else {
            swiftUIFlow = UIViewController()
        }
        
        return swiftUIFlow
    }
    
    func setupSwiftUIKitViews() -> UIViewController {
        let uiKitFlow = HomeViewController()
        return uiKitFlow
    }
    
    func setupObjectiveCViews() -> UIViewController {
        let objectiveCFlow = ObjCHomeViewController()
        return objectiveCFlow
    }
}

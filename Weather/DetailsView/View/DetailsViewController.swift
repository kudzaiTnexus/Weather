//
//  DetailsViewController.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit


final class DetailsViewController: WeatherBaseViewController {
    
    private lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        return bdView
    }()
    
    private let weatherView: DetailsView = {
        let detailsView = DetailsView(frame: .zero)
        return detailsView
    }()
    
    let weatherViewHeight = UIScreen.main.bounds.height / 2
    var isPresenting = false
    var coordinate: Coordinates
    lazy var viewModel: WeatherForecastViewModel = WeatherForecastViewModel(coordinates: self.coordinate, viewCallback: self)
    
    // MARK: - ViewController Lifecycle
    
    init(coordinate: Coordinates) {
        
        self.coordinate = coordinate
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorViewController.delegate = self
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(weatherView)

        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.heightAnchor.constraint(equalToConstant: weatherViewHeight).isActive = true
        weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showActivityIndicator()
        self.viewModel.getForeCast()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController : ViewWeatherDataCallBack {
    func locationWeather(forecast: Forecast) {
        self.weatherView.configureView(with: forecast)
        self.hideErrorView()
        self.hideActivityIndicator()
    }
    
    func onFailure(with error: Error) {
        self.hideActivityIndicator()
        self.showErrorView(with: error.localizedDescription)
    }
    
    override func onRetryTap() {
        self.hideErrorView()
        self.viewModel.getForeCast()
    }
}

extension DetailsViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let viewController = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(viewController.view)
            
            weatherView.frame.origin.y += weatherViewHeight
            backdropView.alpha = 1
            
            UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveEaseIn], animations: {
                self.weatherView.frame.origin.y -= self.weatherViewHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseIn], animations: {
                self.weatherView.frame.origin.y += self.weatherViewHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}

//
//  DetailsView.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    // MARK: - View Components
    
    private var weatherDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeed: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private let country: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private let verticalstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.animateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Views

extension DetailsView {
    
    func setupView() {
        self.backgroundColor = UIColor.lightGray
        
        verticalstackView.addArrangedSubview(weatherIcon)
        verticalstackView.addArrangedSubview(weatherDescription)
        verticalstackView.addArrangedSubview(windSpeed)
        verticalstackView.addArrangedSubview(country)
        
        addSubview(verticalstackView)
        verticalstackView.translatesAutoresizingMaskIntoConstraints = false
        verticalstackView.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor).isActive = true
        verticalstackView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor).isActive = true
        verticalstackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    
    }

    
    func configureView(with forecast: Forecast) {
        self.weatherDescription.text = "Description: " + forecast.weather.first.debugDescription
        self.weatherIcon.text = forecast.weather.first?.icon
        self.windSpeed.text = "Speed: " + String(forecast.wind.speed)
        self.country.text = "Base: " + forecast.base
    }
}

// MARK: - View Animations

extension DetailsView {
    func animateViews() {
        
        let animations = {
            self.verticalstackView.transform =  CGAffineTransform.identity
            self.verticalstackView.alpha = 1
            
            self.weatherDescription.alpha = 1
            self.weatherIcon.alpha = 1
            self.windSpeed.alpha = 1
            self.country.alpha = 1
            
            self.layoutIfNeeded()
        }
        
        verticalstackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        verticalstackView.alpha = 0
        
        self.weatherDescription.alpha = 0
        self.weatherIcon.alpha = 0
        self.windSpeed.alpha = 0
        self.country.alpha = 0
        
        UIView.animate(withDuration: 1.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity:0.7,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: nil)
    }
}

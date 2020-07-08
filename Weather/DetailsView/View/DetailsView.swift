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
    
    private let weatherIcon: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.iron
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private var weatherDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 28, weight: .light)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperature: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 45, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeed: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Wind Speed"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let windDirection: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let windDirectionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Wind Direction"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let pressure: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Pressure"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let humidity: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Humidity"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let gridStackView: GridStackView = {
        
        let gridStackView = GridStackView()
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return gridStackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
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
        
        self.applyGradient(colours: [UIColor.snow.withAlphaComponent(0.4),
                                     UIColor.aqua.withAlphaComponent(0.7)])
        self.cornerRadius(20, corners: [.topLeft, .topRight])
        self.animateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Views

extension DetailsView {
    
    func setupView() {
        
        gridStackView.addArranged(subviews: [(windSpeedLabel, windSpeed),
                                             (windDirectionLabel, windDirection),
                                             (pressureLabel, pressure),
                                             (humidityLabel, humidity)])
        
        horizontalStackView.addArrangedSubview(temperature)
        horizontalStackView.addArrangedSubview(gridStackView)
        
        mainStackView.addArrangedSubview(weatherIcon)
        mainStackView.addArrangedSubview(locationName)
        mainStackView.addArrangedSubview(weatherDescription)
        mainStackView.addArrangedSubview(horizontalStackView)
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
    }
    
    
    func configureView(with forecast: Forecast) {
        self.weatherDescription.text = (forecast.weather.first?.description ?? "").uppercased()
        self.weatherIcon.text = forecast.weather.first?.icon
        self.windSpeed.text = String(forecast.wind.speed)
        self.windDirection.text = String(forecast.wind.deg)
        self.locationName.text = "📌 " + forecast.name + "📌 "
        self.pressure.text = String(forecast.main.pressure)
        self.humidity.text = String(forecast.main.humidity)
        self.temperature.text = String(Int((forecast.main.temp ?? 0) - 273.15)) + "°C"
    }
}

// MARK: - View Animations

extension DetailsView {
    func animateViews() {
        
        let animations = {
            self.mainStackView.transform =  CGAffineTransform.identity
            self.mainStackView.alpha = 1
            
            self.weatherDescription.alpha = 1
            self.weatherIcon.alpha = 1
            self.windSpeed.alpha = 1
            self.locationName.alpha = 1
            self.gridStackView.alpha = 1
            
            self.layoutIfNeeded()
        }
        
        mainStackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        mainStackView.alpha = 0
        
        self.weatherDescription.alpha = 0
        self.weatherIcon.alpha = 0
        self.windSpeed.alpha = 0
        self.locationName.alpha = 0
        self.gridStackView.alpha = 0
        
        UIView.animate(withDuration: 1.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity:0.7,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: nil)
    }
}

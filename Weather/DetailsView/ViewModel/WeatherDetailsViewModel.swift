//
//  WeatherDetailsViewModel.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

class WeatherForecastViewModel {
    
    private var service: WeatherDetailsService = WeatherDetailsServiceImplementation()
    private weak var viewCallback: ViewWeatherDataCallBack?
    private var coordinates: Coordinates
    
    init(coordinates: Coordinates?, viewCallback: ViewWeatherDataCallBack?) {
        self.coordinates = coordinates!
        self.viewCallback = viewCallback
    }

    func getForeCast() {
        service.getWeatherDetailsFrom(location: self.coordinates) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewCallback?.onFailure(with: error)
                }
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.viewCallback?.locationWeather(forecast: forecast)
                }
            }
        }
    }
}

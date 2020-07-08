//
//  WeatherdetailsRepository.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol WeatherdetailsRepository {
    func getForeCast(from coordinates: Coordinates,
                     completion:@escaping (Result<Forecast, ServiceError>) -> Void)
}

class WeatherdetailsRepositoryImplementation: WeatherdetailsRepository {
    
    private var service: WeatherDetailsService = WeatherDetailsServiceImplementation()
    private let internetReachability = Reachability()
    
    func getForeCast(from coordinates: Coordinates,
                     completion: @escaping (Result<Forecast, ServiceError>) -> Void) {
        
        if !internetReachability.isInternetAvailable() {
            
            if let forecast = WeatherdetailsCache.shared.getForecast(for: coordinates) {
                completion(.success(forecast))
            }else{
                completion(.failure(.networkError))
            }
            
        } else {
            service.getWeatherDetailsFrom(location: coordinates) { result in
                switch result {
                case .success(let forecast):
                    WeatherdetailsCache.shared.cacheLocationData(cacheKey: coordinates, forecast: forecast)
                    completion(.success(forecast))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}

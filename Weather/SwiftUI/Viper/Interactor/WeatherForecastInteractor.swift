//
//  WeatherForecastInteractor.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/10.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
protocol WeatherDetailInteractorProtocol {
    func getForeCast(from coordinates: Coordinates,
                     completion: @escaping (Result<Forecast, ServiceError>)-> Void)
}

@available(iOS 13.0, *)
final class WeatherDetailInteractor {
    private let dependencies: WeatherDetailInteractorDependenciesProtocol
    private var cancellables = Set<AnyCancellable>()
    private let internetReachability = Reachability()
    
    init(dependencies: WeatherDetailInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

@available(iOS 13.0, *)
extension WeatherDetailInteractor: WeatherDetailInteractorProtocol {
    
    func getForeCast(from coordinates: Coordinates,
                     completion: @escaping (Result<Forecast, ServiceError>) -> Void) {
        
        
        if !internetReachability.isInternetAvailable() {
            
            if let forecast = WeatherdetailsCache.shared.getForecast(for: coordinates) {
                completion(.success(forecast))
            }else{
                completion(.failure(.networkError))
            }
            
        } else {
            
            self.dependencies.apiService.getForecast(for: coordinates).sink(receiveCompletion: { publisherCompletion in
                
                switch publisherCompletion {
                case .finished:
                    print("🏁 finished")
                case .failure(let error):
                    completion(.failure(.requestFailed(error: error)))
                }
            }) { forecast in
                WeatherdetailsCache.shared.cacheLocationData(cacheKey: coordinates,
                                                             forecast: forecast)
                completion(.success(forecast))
            }.store(in: &cancellables)
        }
    }
}

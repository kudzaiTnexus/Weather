//
//  APIService.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/10.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Combine
import Foundation

@available(iOS 13.0, *)
protocol APIServiceProvider {
    var apiService: APIService { get }
}

@available(iOS 13.0, *)
final class APIService {
    private let urlSession: URLSession = .shared
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    private let apiKey = "5b10e76c6001dd1d3c1f259484f1fce2"
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    func getForecast(for coordinates: Coordinates) -> AnyPublisher<Forecast, Error> {
        
        let endpoint: String =  baseURL+"lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid="+apiKey
        
        guard let url = URL(string: endpoint) else {
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        let forecastUrlRequest = URLRequest(url: url)
        return urlSession.dataTaskPublisher(for: forecastUrlRequest)
            .map { $0.data }
            .decode(type: Forecast.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

//
//  WeatherDetailsService.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol WeatherDetailsService {
    func getWeatherDetailsFrom(location: Coordinates, completion:@escaping (_ result: Result<Forecast, ServiceError>) -> Void)
}

struct WeatherDetailsServiceImplementation: WeatherDetailsService, ServiceClient {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "5b10e76c6001dd1d3c1f259484f1fce2"

    func getWeatherDetailsFrom(location: Coordinates, completion result:@escaping (_ result: Result<Forecast, ServiceError>) -> Void) {
        
        let endpoint: String =  baseUrl+"lat=\(location.latitude)&lon=\(location.longitude)&appid="+apiKey
        
        let serviceUrl =  URL(string: endpoint)
        
        fetchResources(url: serviceUrl!, completion: result)
    }
    
    
}

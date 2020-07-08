//
//  WeatherdetailsCache.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherdetailsCache {
    
    var cache: [Coordinates : Forecast] = [:]
    static let shared = WeatherdetailsCache()
    
    private init() { }
    
    func cacheLocationData(cacheKey: Coordinates, forecast: Forecast) {
        cache[cacheKey] = forecast
    }
    
    func getForecast(for cacheKey: Coordinates) -> Forecast? {
        
        let currentLocation: CLLocation = CLLocation(latitude: cacheKey.latitude,
                                                      longitude: cacheKey.longitude)
        
        ///check if coordinates are within a 20km radius of any cached cooordinates
        let cacheValue = cache.first(where: {
            let cachedLocations: CLLocation = CLLocation(latitude: $0.key.latitude,
                                                         longitude: $0.key.longitude)
            
            return currentLocation.distance(from: cachedLocations) <= 20000.0
        })
        
        if let cacheValue = cacheValue {
            return cache[cacheValue.key]
        }
        
        return nil
    }
    
    func clearCache() {
        cache = [:]
    }
    
}

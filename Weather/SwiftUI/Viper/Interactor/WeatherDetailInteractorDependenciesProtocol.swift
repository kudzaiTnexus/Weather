//
//  WeatherDetailInteractorDependenciesProtocol.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/12.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
protocol WeatherDetailInteractorDependenciesProtocol: APIServiceProvider { }

@available(iOS 13.0, *)
struct WeatherDetailInteractorDependencies: WeatherDetailInteractorDependenciesProtocol {
    let apiService: APIService
    
    init() {
        apiService = APIService()
    }
}

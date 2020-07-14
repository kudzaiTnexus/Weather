//
//  Forecast.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

extension Forecast {
    init() {
        coord = Coord(lon: 0, lat: 0)
        weather = []
        base = ""
        main = Main(temp: nil, feelsLike: nil, tempMin: nil, tempMax: nil, pressure: 0, humidity: 0)
        wind = Wind(speed: 0, deg: 0)
        clouds = Clouds(all: 0)
        dt = 0
        sys = Sys(sunrise: 0, sunset: 0)
        timezone = 0
        id = 0
        name = ""
        cod = 0
    }
}

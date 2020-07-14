//
//  ViewWeatherDataCallBack.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol ViewWeatherDataCallBack: class {
    func locationWeather(forecast: Forecast)
    func onFailure(with error: Error)
}

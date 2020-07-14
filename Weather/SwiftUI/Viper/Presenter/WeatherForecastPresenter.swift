//
//  WeatherForecastPresenter.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/10.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
class WeatherForecastPresenter: ObservableObject {
    
    private let interactor: WeatherDetailInteractorProtocol
    
    private(set) var forecast: Forecast {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: WeatherDetailInteractorProtocol) {
        self.interactor = interactor
        
        self.forecast = Forecast()
    }
    
    func getDetailsViewData(from coordinates: Coordinates) {
        interactor.getForeCast(from: coordinates) { result in
            switch result {
            case .failure(let error):
                print(error)
            case.success(let forecast):
                self.forecast = forecast
            }
        }
    }
}

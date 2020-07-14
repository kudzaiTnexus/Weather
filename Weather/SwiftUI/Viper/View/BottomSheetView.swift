//
//  BottomSheetView.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/09.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import SwiftUI


@available(iOS 13.0.0, *)
struct BottomSheetView: View {
    
    @ObservedObject var presenter: WeatherForecastPresenter
    
    var body: some View {
        return VStack {
            Text(presenter.forecast.weather.first?.icon ?? "")
                .font(.system(size: 100))
                .padding(5)
            Text("📌\(presenter.forecast.name)📌")
                .font(.system(size: 28))
                .fontWeight(.thin)
                .accentColor(.gray)
                .padding(3)
            Text((presenter.forecast.weather.first?.description ?? "").uppercased())
                .font(.system(size: 28))
                .fontWeight(.thin)
                .foregroundColor(.white)
                .padding(8)
            
            HStack(spacing: 0) {
                
                VStack {
                    Text(String(Int((presenter.forecast.main.temp ?? 0) - 273.15)) + "°C")
                        .font(.system(size: 45))
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                VStack {
                    
                    Text("Wind Speed\t \(presenter.forecast.wind.speed)")
                        .font(.system(size: 14))
                    Text("Wind Direction\t \(String(presenter.forecast.wind.deg))")
                        .font(.system(size: 14))
                    Text("Pressure\t \(String(presenter.forecast.main.pressure))")
                        .font(.system(size: 14))
                    Text("Humidity\t \(String(presenter.forecast.main.humidity))")
                        .font(.system(size: 14))
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
            }.padding(.bottom, 80)
        }
    }
}


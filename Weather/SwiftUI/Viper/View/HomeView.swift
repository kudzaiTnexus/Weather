//
//  HomeView.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import SwiftUI
import CoreLocation

let screen = UIScreen.main.bounds
var worldMapView: MKMapView!
var timer : Timer?

@available(iOS 13.0.0, *)
struct HomeView: View {
    
    @ObservedObject var presenter: WeatherForecastPresenter 
    @State var showWeatherDetails: Bool = false
    @State var touchPoint = CGPoint(x: 0, y: 0)
    
    @State var locationManager = CLLocationManager()
    @State var showMapAlert = false
    
    var body: some View {
        ZStack{
            
           MapView(locationManager: $locationManager,
            showMapAlert: $showMapAlert)
                .alert(isPresented: $showMapAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: { self.openDeviceSettings() }))
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ (touch) in
                        
                        if timer?.isValid ?? false {
                            self.showWeatherDetails(for: touch.location)
                            withAnimation {
                                self.showWeatherDetails = true
                            }
                            self.stopTimer()
                        } else {
                            withAnimation {
                                self.showWeatherDetails = false
                            }
                            self.startTimer()
                        }
                    })
            )
            
            
            if showWeatherDetails {
                BottomSheetView(presenter: presenter)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.snow.withAlphaComponent(0.8)), Color(UIColor.aqua.withAlphaComponent(0.7))]),
                                               startPoint: .top, endPoint: .bottom))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: screen.height/5)
            }
        }
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    func showWeatherDetails(for point: CGPoint) {
        
        let selectedCoordinates = worldMapView.convert(point, toCoordinateFrom: worldMapView)
        
        let coordinates = Coordinates(latitude: selectedCoordinates.latitude,
                                      longitude: selectedCoordinates.longitude)
        
        self.presenter.getDetailsViewData(from: coordinates)
    }
}


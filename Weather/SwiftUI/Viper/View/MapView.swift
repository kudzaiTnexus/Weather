//
//  MapView1.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/12.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import SwiftUI
import MapKit

// MARK: Struct that handle the map
@available(iOS 13.0, *)
struct MapView: UIViewRepresentable {
    
    @Binding var locationManager: CLLocationManager
    @Binding var showMapAlert: Bool
    
    let mapView = MKMapView()
    
    ///Creating map view at startup
    func makeUIView(context: Context) -> MKMapView {
        locationManager.delegate = context.coordinator
        worldMapView = mapView
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(mapView: self)
    }
    
    //MARK: - Core Location manager delegate
    class Coordinator: NSObject, CLLocationManagerDelegate {
        
        var mapView: MapView
        
        init(mapView: MapView) {
            self.mapView = mapView
        }
        
        ///Switch between user location status
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .restricted:
                break
            case .denied:
                mapView.showMapAlert.toggle()
                return
            case .notDetermined:
                mapView.locationManager.requestWhenInUseAuthorization()
                return
            case .authorizedWhenInUse:
                return
            case .authorizedAlways:
                mapView.locationManager.allowsBackgroundLocationUpdates = true
                mapView.locationManager.pausesLocationUpdatesAutomatically = false
                return
            @unknown default:
                break
            }
            mapView.locationManager.startUpdatingLocation()
        }
    }
}


//
//  HomeViewController.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: WeatherBaseViewController {
    
    private var selectedCoordinates: Coordinates!
    
    var timer : Timer?
    
    var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        return mapView
    }()
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        self.verifyLocationServicesAreEnabled()
    }
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(tap)
        
        self.view.addSubview(mapView)
        mapView.layoutPinToSuperviewEdges()
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func verifyLocationServicesAreEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
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
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    @objc func doubleTapped() {
        self.showWeatherDetails()
    }
    
    func showWeatherDetails() {
        let detailsViewContoller = DetailsViewController(coordinate: self.selectedCoordinates)
        detailsViewContoller.modalPresentationStyle = .custom
        self.present(detailsViewContoller, animated: true, completion: nil)
    }
}


extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchPoint = touch.location(in: mapView)
            let location = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            self.selectedCoordinates = Coordinates(latitude: location.latitude, longitude: location.longitude)
            
            if timer?.isValid ?? false {
                self.showWeatherDetails()
                self.stopTimer()
            }
            
            self.startTimer()
            
        }
    }
    
    
    
}


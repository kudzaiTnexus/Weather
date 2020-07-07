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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(tap)
        
        self.view.addSubview(mapView)
        mapView.layoutPinToSuperviewEdges()
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
    
    func pinViewOnUserLocation() {
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
            self.showAlert(title: "Error", message: "Location is required for this app to work please turn on location")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            pinViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            self.showAlert(title: "Error", message: "Please turn on location")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            self.showAlert(title: "Error", message: "Location restricted")
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
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
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}


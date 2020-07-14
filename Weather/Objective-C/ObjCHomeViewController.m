//
//  ObjCHomeViewController.m
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

#import "ObjCHomeViewController.h"

@interface ObjCHomeViewController () 

@end

@implementation ObjCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self currentUserLocation];
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview: mapView];
    
    mapView.showsUserLocation = true;
    [mapView setCenterCoordinate: currentLocation.coordinate];
    
    [self setupLocationPinOnMap];
}

-(void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

-(void) setupLocationPinOnMap {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coordforpin = {.latitude = currentLocation.coordinate.latitude,
        .longitude = currentLocation.coordinate.longitude};
    [annotation setCoordinate:coordforpin];
    [annotation setTitle:@"Pin is here"];
    [mapView addAnnotation:annotation];
}

-(void) currentUserLocation {
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    [geocoder reverseGeocodeLocation: currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!(error)) {
            return;
        } else {
            NSLog(@"Geocode failed with error %@", error);
            NSLog(@"\nCurrent Location Not Detected\n");
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

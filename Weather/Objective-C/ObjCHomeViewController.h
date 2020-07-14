//
//  ObjCHomeViewController.h
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/08.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjCHomeViewController : UITabBarController  <MKMapViewDelegate, CLLocationManagerDelegate>  {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    MKMapView *mapView;
}
@end

NS_ASSUME_NONNULL_END

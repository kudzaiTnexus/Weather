//
//  Coordinates.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import MapKit

struct Coordinates {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

extension Coordinates: Hashable {
    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude 
    }
}

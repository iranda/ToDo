//
//  Loction.swift
//  ToDo
//
//  Created by Daria Daria on 2017-03-15.
//  Copyright © 2017 d.sirous. All rights reserved.
//

import Foundation
import CoreLocation

struct Location : Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return (lhs.name == rhs.name &&
                (lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
                lhs.coordinate?.longitude == rhs.coordinate?.longitude))
    }
}

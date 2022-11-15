//
//  MKCoordinateRegion+Extensions.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/11/22.
// https://www.youtube.com/watch?v=cOD1l2lv2Jw

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 57.77, longitude: 14.16), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}

//
//  LocationManager.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/2/22.
//
// Code inspired by: https://www.youtube.com/watch?v=X2W9MPjrIbk and https://play.ju.se/media/iOS+Development+2022+-+Quiz+App+-+Loading+data+from+a+Server+Workshop/0_5j5xjg5q
//  https://designcode.io/swiftui-advanced-handbook-data-from-json
// https://www.youtube.com/watch?v=cOD1l2lv2Jw

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    @Published var cityName: String?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.requestAlwaysAuthorization()
//        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
//        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
//        manager.requestLocation()
    }
    
    let geocoder = CLGeocoder()
    
    func reverseGeoCode(latitude: Double, longitude: Double) {
        let coordinates = CLLocation.init(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(coordinates) { placemarks, error in
            if let placemarks = placemarks {
                self.cityName = placemarks[0].locality
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    // Forward geolocation
    func forwardGeoCode(cityName: String) {
        geocoder.geocodeAddressString(cityName) { placemarks, error in
            if let placemarks = placemarks {
                self.location?.latitude = placemarks[0].location?.coordinate.latitude ?? 0
                self.location?.longitude = placemarks[0].location?.coordinate.longitude ?? 0
                self.cityName = cityName
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdatelocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.location = location.coordinate
            self?.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        }
    }
}

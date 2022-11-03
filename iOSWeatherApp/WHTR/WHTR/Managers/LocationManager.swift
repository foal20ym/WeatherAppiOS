//
//  LocationManager.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/2/22.
//
// Code inspired by: https://www.youtube.com/watch?v=X2W9MPjrIbk and https://play.ju.se/media/iOS+Development+2022+-+Quiz+App+-+Loading+data+from+a+Server+Workshop/0_5j5xjg5q
//  https://designcode.io/swiftui-advanced-handbook-data-from-json


import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}

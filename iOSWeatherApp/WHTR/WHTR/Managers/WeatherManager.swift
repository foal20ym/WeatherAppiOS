//
//  WeatherManager.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/3/22.
//

import Foundation
import CoreLocation
import Combine
// Might not need COMBINE, but it depends. Remove if that is the case.

class WeatherManager {
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        print("\(latitude), \(longitude)")
        
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,relativehumidity_2m&daily=temperature_2m_max,temperature_2m_min&current_weather=true&timezone=auto") else { fatalError("Missing URL") }
        // This function will use the new async await method introduced in 2021
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}


struct ResponseBody: Decodable {
    var latitude: Float
    var longitude: Float
    var generationtime_ms: Float
    var utc_offset_seconds: Int
    var timezone: String
    var timezone_abbreviation: String
    var elevation: Int
    
    var current_weather: current_weather
    var hourly_units: hourly_units
    var hourly: hourly
    var daily_units: daily_units
    var daily: daily
}

struct current_weather: Decodable {
    var temperature: Float
    var windspeed: Float
    var winddirection: Int
    var weathercode: Int
    var time: String
}

struct hourly_units: Decodable {
    var time: String
    var temperature_2m: String
    var relativehumidity_2m: String
}

struct hourly: Decodable {
    var time: [String]
    var temperature_2m: [Float]
    var relativehumidity_2m: [Int]
}

struct daily_units: Decodable {
    var time: String
    var temperature_2m_max: String
    var temperature_2m_min: String
}

struct daily: Decodable {
    var time: [String]
    var temperature_2m_max: [Float]
    var temperature_2m_min: [Float]
}


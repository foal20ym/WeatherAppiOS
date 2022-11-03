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
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m&daily=weathercode&timezone=Europe%2FLondon") else { fatalError("Missing URL") }
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
    
    var hourly_units: hourly_units
    var hourly: hourly
}
struct hourly_units: Decodable {
    var temperature_2m: String
    var time: String
}

struct hourly: Decodable {
    var time: [String]
    var temperature_2m: [Float]
}


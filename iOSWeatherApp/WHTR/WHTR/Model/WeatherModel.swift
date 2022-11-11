//
//  WeatherModel.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/11/22.
//

import Foundation
import CoreLocation
import Combine

class WeatherModel: ObservableObject {
    
    private let urlString = "https://api.open-meteo.com/v1/forecast?latitude=57.11&longitude=14.16&hourly=temperature_2m,relativehumidity_2m&daily=temperature_2m_max,temperature_2m_min&current_weather=true&timezone=auto"
    
    private var cancellable: Cancellable?
    
    @Published var weather: [ResponseBody] = []
    
    init(){
    }
    
    func loadWeather(){
        guard let url = URL(string: urlString) else {
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { data, response in
                print(String(data: data, encoding: .utf8))
            })
    }
}

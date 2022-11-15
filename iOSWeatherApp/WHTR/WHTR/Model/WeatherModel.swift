//
//  WeatherModel.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/11/22.
//

import Foundation
import CoreLocation
import Combine
/*
class WeatherModel: ObservableObject {
    
    private let urlString = "https://api.open-meteo.com/v1/forecast?latitude=57.11&longitude=14.16&hourly=temperature_2m,relativehumidity_2m&daily=temperature_2m_max,temperature_2m_min&current_weather=true&timezone=auto"
    
    private var cancellable: Cancellable?
    private let jsonDecoder = JSONDecoder()
    
    @Published var weather: ResponseBody
    
    init(){
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func loadWeather(){
        guard let url = URL(string: urlString) else {
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: ResponseBody.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] data in
                self?.weather = data.self
            })
    }
}
*/

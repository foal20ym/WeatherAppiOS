//
//  ContentView.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    // Added @StateObject propertywrapper so that the view can be notified everytime that the @Published variables in the LocationManager is updated.
    @StateObject var locationManager = LocationManager()
    
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var menuClicked = false
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager
                                    .getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    StartView()
                        .environmentObject(locationManager)
                }
            }
            if menuClicked {
                LoadingView()
            }
        }
        .background(Color(hue: 0.649, saturation: 0.884, brightness: 0.561))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

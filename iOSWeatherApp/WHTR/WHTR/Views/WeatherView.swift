//
//  WeatherView.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/3/22.
//
// Code from: https://designcode.io/swiftui-advanced-handbook-data-from-json

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    let tempVarToInt = Int(ceil(weather.hourly.temperature_2m[0]))
                    
                    Text("Timezone: \(weather.timezone)")
                        .bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            
                            Text("Clear")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        let tempVarToInt = Int(ceil(weather.hourly.temperature_2m[0]))
                        Text("\(tempVarToInt)\(weather.hourly_units.temperature_2m)")
                            .font(.system(size: 80))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.649, saturation: 0.884, brightness: 0.561))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

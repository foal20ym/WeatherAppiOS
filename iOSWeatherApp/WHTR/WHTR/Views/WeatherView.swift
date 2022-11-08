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
    var weatherCodeDictionary =
    [
        0:"Clear", 1:"Mainly clear", 2:"Partly cloudy",
        3:"Overcast", 45:"Fog", 48:"Thick fog",
        51:"Light drizzle", 53:"Moderate drizzle",55:"Dense drizzle",
        56:"Light freezing drizzle", 57:"Dense freezing drizzle",61:"Light rain fall",
        63:"Moderate rain fall", 65:"Heavy rain fall",66:"Light freezing rain",
        67:"Heavy freezing rain", 71:"Light snow fall",73:"Moderate snow fall",
        75:"Heavy snow fall", 77:"Snow",80:"Slight rain showers",
        81:"Heavy rain showers", 82:"Violent rain showers",85:"Moderate snow showers",
        86:"Heavy snow showers", 95:"Thunderstorm",96:"Thunderstorm with slight hail", 99:"Thunderstorm with heavy hail"
    ]

    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Timezone: \(weather.timezone)")
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            
                            Text("\(weatherCodeDictionary[weather.current_weather.weathercode] ?? "Clear")")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        let tempVarToInt = Int(weather.current_weather.temperature)
                        Text("\(tempVarToInt)\(weather.hourly_units.temperature_2m)")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .padding()
                
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value:  String(Int(weather.daily.temperature_2m_min[0])) + "°")
                        
                        Spacer()
                        
                        WeatherRow(logo: "thermometer", name: "Max temp", value: String(Int(weather.daily.temperature_2m_max[0])) + "°")
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Windspeed", value: String(Int(ceil(weather.current_weather.windspeed/3))) + " m/s")
                        
                        Spacer()
                        
                        WeatherRow(logo: "humidity", name: "Humidity", value: String(weather.hourly.relativehumidity_2m[0]) + "%")
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom)
                .foregroundColor(Color(hue: 0.602, saturation: 0.881, brightness: 0.375))
                .background(.white)
                //.cornerRadius(20, corners: [.topLeft, .topLeft])
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.649, saturation: 0.884, brightness: 0.561))
        .preferredColorScheme(.dark)
    }
    func wc(inputWC: Int){
        print("\(weatherCodeDictionary[inputWC] ?? "Clear")")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}


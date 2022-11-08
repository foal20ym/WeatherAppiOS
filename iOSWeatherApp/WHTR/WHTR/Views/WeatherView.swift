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
        0:"Clear", 1:"Mainly clear", 2:"cloud.sun.fill",
        3:"Overcast", 45:"Fog", 48:"Thick fog",
        51:"Light drizzle", 53:"Moderate drizzle",55:"Dense drizzle",
        56:"Light freezing drizzle", 57:"Dense freezing drizzle",61:"Light rain fall",
        63:"Moderate rain fall", 65:"Heavy rain fall",66:"Light freezing rain",
        67:"Heavy freezing rain", 71:"Light snow fall",73:"Moderate snow fall",
        75:"Heavy snow fall", 77:"Snow",80:"Slight rain showers",
        81:"Heavy rain showers", 82:"Violent rain showers",85:"Moderate snow showers",
        86:"Heavy snow showers", 95:"Thunderstorm",96:"Thunderstorm with slight hail", 99:"Thunderstorm with heavy hail"
    ]
    var weatherCodeSymbolDictionary =
    [
        0:"sun.max.fill", 1:"sun.min.fill", 2:"Partly cloudy",
        3:"cloud", 45:"cloud.fog", 48:"cloud.fog.fill",
        51:"cloud.drizzle", 53:"cloud.drizzle",55:"cloud.drizzle.fill",
        56:"cloud.drizzle.fill", 57:"cloud.drizzle.fill",61:"cloud.drizzle.fill",
        63:"cloud.heavyrain", 65:"cloud.heavyrain.fill",66:"cloud.heavyrain",
        67:"cloud.heavyrain.fill", 71:"snowflake",73:"cloud.snow",
        75:"cloud.snow.fill", 77:"cloud.snow.fill",80:"cloud.sun.rain",
        81:"cloud.sun.rain.fill", 82:"cloud.heavyrain.fill",85:"cloud.snow.fill",
        86:"cloud.snow.fill", 95:"cloud.bolt.fill",96:"cloud.bolt.rain.fill", 99:"cloud.bolt.rain.fill"
    ]
    
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            VStack {
                // Temporary solution
                Group{
                    Text(" ")
                }
                .padding()
                .ignoresSafeArea(.all)
                // Temporary solution
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Timezone: \(weather.timezone)")
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName:
    "\(weatherCodeSymbolDictionary[weather.current_weather.weathercode] ?? "sun.max")")
                                .font(.system(size: 45))
                            
                            Text("\(weatherCodeDictionary[weather.current_weather.weathercode] ?? "Clear")")
                        }
                        .frame(width: 150, alignment: .leading)
                        .foregroundColor(.black)
                        
                        Spacer()
                        
                        let tempVarToInt = Int(weather.current_weather.temperature)
                        Text("\(tempVarToInt)°")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    //.frame(height: 80)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            VStack{
                                HStack{
                                    ForEach(weather.daily.time, id: \.self) { time in
                                        Text("\(time)")
                                            .foregroundColor(.black)
                                            .frame(width: 100, height: 50)
                                            .background(.orange)
                                    }
                                }
                                .background(.orange)
                                    HStack{
                                        ForEach(weather.daily.temperature_2m_min, id: \.self) { temperature in
                                            Text("Min: \(Int(temperature))°")
                                                .foregroundColor(.black)
                                                .frame(width: 100, height: 25)
                                                .background(.orange)
                                        }
                                    }
                                    HStack{
                                        ForEach(weather.daily.temperature_2m_max, id: \.self) { temperature in
                                            Text("Max: \(Int(temperature))°")
                                                .foregroundColor(.black)
                                                .frame(width: 100, height: 25)
                                                .background(.orange)
                                        }
                                    }
                                .background(.orange)
                            } // VStack som håller time, min och max vertikalt
                            .foregroundColor(.white)
                            .background(.orange)
                        } // HStack som håller alla element horisontellt
                        .frame(width: .infinity, height: 112)
                    } // ScrollView
                    .frame(width: .infinity, height: 120)
                    .background(.white)
                    
                    
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
                //.background(.white)
                //.cornerRadius(20, corners: [.topLeft, .topLeft])
            }
            
            
        }
        .gradientBackground()
        .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

struct GradientBackground : ViewModifier {
    
    @State private var animateGradient = false
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(colors: [.orange, .red, .purple],
                               startPoint: animateGradient ? .topLeading : .bottomLeading,
                               endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                
            )
    }
}

extension View {
    func gradientBackground () -> some View {
        modifier(GradientBackground())
    }
}

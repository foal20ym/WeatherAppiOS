//
//  WHTRApp.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/2/22.
//

import SwiftUI

@main
struct WHTRApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView(weather: previewWeather)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                ListView()
                    .tabItem {
                        Label("My list", systemImage: "list.dash")
                    }
            }
            //ContentView()
        }
    }
}

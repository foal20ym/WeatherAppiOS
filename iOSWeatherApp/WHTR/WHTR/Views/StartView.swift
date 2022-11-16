//
//  StartView.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/2/22.
//

import SwiftUI
import CoreLocationUI

struct StartView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to WTHR")
                    .bold().font(.title)
                
                Text("Please share your current location to get the weather in your area.")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gradientBackground()
        .ignoresSafeArea(.all)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

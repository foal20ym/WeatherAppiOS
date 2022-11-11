//
//  ListView.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/9/22.
//

import SwiftUI

struct ListView: View {
    
    @State var myList: [ResponseBody] = []
    
    @State private var elements = ["Donald Duck", "Mickey Mouse", "Goofy", "Pluto"]
    @State private var searchString = ""
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    
    var filteredElements: [String] {
        guard !searchString.isEmpty else {
            return elements
        }
        return elements.filter { $0.lowercased().contains(searchString.lowercased()) }
    }
    
    var body: some View {
        var c = locationManager.forwardGeoCode(cityName: searchString)
        
        var lo = locationManager.location?.latitude
        var la = locationManager.location?.longitude
        
        NavigationStack {
            List(filteredElements, id: \.self) { element in
                Text(element)
            }
            .navigationTitle("My List")
            .searchable(text: $searchString)
        }
        
        Spacer()
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

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
    
    @StateObject var locationManager = LocationManager()
    @State private var searchString = ""
    @StateObject private var vm = SearchResultsViewModel()
    
    @State var weather: ResponseBody?
    var weatherManager = WeatherManager()
    var filteredElements: [String] {
        guard !searchString.isEmpty else {
            return elements
        }
        return elements.filter { $0.lowercased().contains(searchString.lowercased()) }
    }
    
    @State var searchLocations: [String] = []
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                List(vm.places) { place in
                    Text(place.name)
                        .onTapGesture {
                            print("\(place.latitude):\(place.longitude)")
                            
                        }

                }
                
                List {
                    ForEach(searchLocations, id: \.self) { location in
                        Text("\(location)")
                    }
                    .onTapGesture {
                        
                    }
                    
                }.searchable(text: $searchString)
                    .onChange(of: searchString, perform: { searchText in
                        
                        if !searchText.isEmpty {
                            vm.search(text: searchText, region: locationManager.region)
                            
                        } else {
                            vm.places = []
                        }
                    })
                    .navigationTitle("Locations")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

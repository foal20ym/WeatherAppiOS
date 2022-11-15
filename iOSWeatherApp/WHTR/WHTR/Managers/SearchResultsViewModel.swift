//
//  SearchResultsViewModel.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/11/22.
//

import Foundation
import MapKit

@MainActor
class SearchResultsViewModel: ObservableObject {
    
    @Published var places = [PlaceViewModel]()
    
    func search( text: String, region: MKCoordinateRegion) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.places = response.mapItems.map(PlaceViewModel.init)
        }
    }
}

struct PlaceViewModel: Identifiable {
    let id = UUID()
    private var mapItem: MKMapItem
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    var name: String {
        mapItem.name ?? ""
    }
    
    var latitude: Double {
        mapItem.placemark.coordinate.latitude ?? 1
    }
    var longitude: Double {
        mapItem.placemark.coordinate.longitude ?? 1
    }
}

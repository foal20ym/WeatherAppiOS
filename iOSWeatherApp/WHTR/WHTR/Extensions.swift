//
//  Extensions.swift
//  WHTR
//
//  Created by Alexander Forsanker on 11/3/22.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "‰.0f", self)
    }
    
    func weatherCode(weatherCode: Int) -> String {
        
        if(weatherCode == 0) {
            return "Clear"
        }
        if(weatherCode == 1 || weatherCode == 2 || weatherCode == 3) {
            return "Mainly clear"
        }
        return "Clear"
    }
    
}



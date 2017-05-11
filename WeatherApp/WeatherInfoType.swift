//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/9/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public enum WeatherInfoType{
    case current
    case forecast
    
    func getURLStringComponent() -> String{
        switch self{
        case .current:
            return "weather"
        case .forecast:
            return "forecast/daily"
        }
        
    }
}

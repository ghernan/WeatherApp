//
//  Enumerations.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/27/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public enum TemperatureUnit : Int{
    case celsius = 0
    case fahrenheit
    case defalt
    
    func name() -> String{
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .defalt:
            return ""
        }
    }
    func queryParameter() -> String{
        switch self {
        case .celsius:
            return "metric"
        case .fahrenheit:
            return "imperial"
        case .defalt:
            return ""
        }
    }
    func measureUnit() -> String{
        switch self {
        case .celsius:
            return "°c"
        case .fahrenheit:
            return "°f"
        case .defalt:
            return ""
        }

    }
}
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

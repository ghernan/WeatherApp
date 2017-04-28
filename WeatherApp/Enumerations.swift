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
        default:
            return ""
        }
    }
    func queryParameter() -> String{
        switch self {
        case .celsius:
            return "metric"
        case .fahrenheit:
            return "imperial"
        default:
            return ""
        }
    }
    func measureUnit() -> String{
        switch self {
        case .celsius:
            return "°c"
        case .fahrenheit:
            return "°f"
        default:
            return ""
        }

    }
}

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
    case undefined
    
    func name() -> String{
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .undefined:
            return ""
        }
    }
    func queryParameter() -> String{
        switch self {
        case .celsius:
            return "metric"
        case .fahrenheit:
            return "imperial"
        case .undefined:
            return ""
        }
    }
    func measureUnit() -> String{
        switch self {
        case .celsius:
            return "°c"
        case .fahrenheit:
            return "°f"
        case .undefined:
            return ""
        }
    }
    func switchUnits(forTemperature temperature: Int ) -> Int {
        switch self {
        case .celsius:
            return (temperature-32)*5/9
        case .fahrenheit:
            return (temperature*9/5)+32
        case .undefined:
            return 0
        }
    }
}


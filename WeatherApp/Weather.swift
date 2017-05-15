//
//  Weather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class Weather {
    var minTemp: Int?
    var maxTemp: Int?
    var currentTemp: Int?
    var dateString = ""
    var tempUnit: TemperatureUnit = .undefined
    
    
    init(with dictionary: JSONDictionary) throws {
        guard let min = dictionary["temp_min"] as? Int else {
            throw SerializationError.missing(
                message: "Minimum Temperature")
            
        }
        guard let max = dictionary["temp_max"] as? Int else {
            throw SerializationError.missing(message: "Maximum Temperature")
        }
        guard let current = dictionary["temp"] as? Int else {
            throw SerializationError.missing(message: "Current Temperature")
        }
        minTemp = min
        maxTemp = max
        currentTemp = current
    }
    
    init(withJSONForecast weather: JSONDictionary, withUnixTimeStamp stamp: Double) throws {
        guard let min = weather["min"] as? Int else {
            throw SerializationError.missing(message: "Minimum Temperature")
            
        }
        guard let max = weather["max"] as? Int else {
            throw SerializationError.missing(message: "Maximum Temperature")
        }
        guard let current = weather["eve"] as? Int else {
            throw SerializationError.missing(message: "Current Temperature")
        }
        minTemp = min
        maxTemp = max
        currentTemp = current
        dateString = Date(timeIntervalSince1970: stamp).dayName()
    }
}




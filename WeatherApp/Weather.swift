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
    var tempUnit: TemperatureUnit = .undef
    
    
    init(with dictionary: JSONDictionary) throws{
        guard let min = dictionary["temp_min"] as? Int else {
            throw SerializationError.missing("Minimum Temperature")
            
        }
        guard let max = dictionary["temp_max"] as? Int else {
            throw SerializationError.missing("Maximum Temperature")
        }
        guard let current = dictionary["temp"] as? Int else {
            throw SerializationError.missing("Current Temperature")
        }
        minTemp = min
        maxTemp = max
        currentTemp = current
        
    }
    init(withJSONForecast weather: JSONDictionary, withUnixTimeStamp stamp: Int) throws {
        guard let min = weather["min"] as? Int else {
            throw SerializationError.missing("Minimum Temperature")
            
        }
        guard let max = weather["max"] as? Int else {
            throw SerializationError.missing("Maximum Temperature")
        }
        guard let current = weather["eve"] as? Int else {
            throw SerializationError.missing("Current Temperature")
        }
        minTemp = min
        maxTemp = max
        currentTemp = current
        dateString = Date(timeIntervalSince1970: TimeInterval(stamp)).getDayName()
        
    }
}



extension Weather : Equatable{
    
    public static func ==(w1: Weather, w2: Weather) -> Bool{
        return w1.currentTemp == w2.currentTemp && w1.minTemp == w2.minTemp && w1.maxTemp == w2.maxTemp
    }
    
}

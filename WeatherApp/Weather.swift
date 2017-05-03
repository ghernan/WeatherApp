//
//  Weather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

struct Weather {
    var minTemp: Int = -100
    var maxTemp: Int = -100
    var currentTemp: Int = -100
    var dateString: String?
    var tempUnit: TemperatureUnit?
    
    
    init(with dict: JSONDictionary){
        if let min = dict["temp_min"] as? Int{
            minTemp = min
        }
        if let max = dict["temp_max"] as? Int{
            maxTemp = max
        }
        if let current = dict["temp"] as? Int{
            currentTemp = current
        }
        
    }
    init(withJSONForecast object: JSONDictionary){
        if let min = object["min"] as? Int{
            minTemp = min
        }
        if let max = object["max"] as? Int{
            maxTemp = max
        }
        if let current = object["eve"] as? Int{
            currentTemp = current
        }
    }
}

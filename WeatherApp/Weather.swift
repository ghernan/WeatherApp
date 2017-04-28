//
//  Weather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

struct Weather {
    var minTemp: Int
    var maxTemp: Int
    var currentTemp: Int
    
    
    init(with dict: JSONDictionary){
        minTemp = dict["temp_min"] as! Int
        maxTemp = dict["temp_max"] as! Int
        currentTemp = dict["temp"] as! Int
    }
    init(withJSONForecast object: JSONDictionary){
        minTemp = object["min"] as! Int
        maxTemp = object["max"] as! Int
        currentTemp = object["eve"] as! Int
    }
}

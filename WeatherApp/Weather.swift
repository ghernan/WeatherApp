//
//  Weather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

struct Weather {
    var minTemp: Double
    var maxTemp: Double
    var currentTemp: Double
    
    
    init(with dict: JSONDictionary){
        minTemp = dict["temp_min"] as! Double
        maxTemp = dict["temp_max"] as! Double
        currentTemp = dict["temp"] as! Double
    }
    init(withJSONObject object: JSONDictionary){
        minTemp = object["min"] as! Double
        maxTemp = object["max"] as! Double
        currentTemp = object["eve"] as! Double
    }
}

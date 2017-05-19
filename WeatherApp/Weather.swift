//
//  Weather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class Weather: Mappable {
    var minTemp: Int?
    var maxTemp: Int?
    var currentTemp: Int?
    var dateString = ""
    var tempUnit: TemperatureUnit = .undefined
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        var stamp = 0.0
        
        minTemp     <- map["main.temp_min"]
        if minTemp == nil {
            minTemp     <- map["temp.min"]
        }
        maxTemp     <- map["main.temp_max"]
        if maxTemp == nil {
            maxTemp     <- map["temp.max"]
        }
        currentTemp <- map["main.temp"]
        if currentTemp == nil {
            currentTemp     <- map["temp.eve"]
        }
        stamp <- map["dt"]
        dateString = Date(timeIntervalSince1970: stamp).dayName()
    }

}




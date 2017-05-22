//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/22/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class ForecastWeather: Weather {
    
    //MARK: - Mapping constructor.
    
    override func mapping(map: Map) {
        
        minTemp         <- map["temp.min"]
        maxTemp         <- map["temp.max"]
        currentTemp     <- map["temp.eve"]
        dateString      <- (map["dt"], Date.dayStringName)
        
    }
    
}

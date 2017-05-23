//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/22/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class CurrentWeather: Weather {

    //MARK: - Mapping constructor.
    
    override func mapping(map: Map) {

        minTemp     <- map["main.temp_min"]
        maxTemp     <- map["main.temp_max"]
        currentTemp <- map["main.temp"]
        
    }    
}

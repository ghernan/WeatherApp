//
//  Weather.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class Weather: Mappable {
    
    //MARK: - Properties
    
    var minTemp: Int?
    var maxTemp: Int?
    var currentTemp: Int?
    var dateString = ""
    var tempUnit: TemperatureUnit = .undefined
    
    //MARK: - Constructor
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {

    }

}




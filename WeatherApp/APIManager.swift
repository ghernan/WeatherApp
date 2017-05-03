//
//  APIManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public class APIManager{
    
   
    static let shared: APIManager = APIManager()

    var queryUnitItem = URLQueryItem(name: "units", value: "metric")
    var queryCityItem = URLQueryItem(name: "q", value: "Chihuahua")
    var appIDQueryItem = URLQueryItem(name: "APPID", value: "0eb7a1c1573c34b2e8c005f3dcbd0201")
    let session = URLSession(configuration: .default)
    let baseURL = "http://api.openweathermap.org/data/2.5/"
    
    
    private init(){
        
    }
}


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
    let session = URLSession(configuration: .default)
    let baseURL = "http://api.openweathermap.org/data/2.5/"
    
    
    private init(){
        
    }
}


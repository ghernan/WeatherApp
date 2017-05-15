//
//  APIManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public class APIManager {
    
   
    static let shared: APIManager = APIManager()    
    let session = URLSession(configuration: .default)
    private let baseURL = "http://api.openweathermap.org/data/2.5/"
    private var appIDQueryItem = URLQueryItem(name: "APPID", value: "0eb7a1c1573c34b2e8c005f3dcbd0201")
    
    func returnURL(fromURLStringComponent urlStringComponent: String,  withQueryItems queryList: [URLQueryItem]) -> URL {
        
        var urlComponent = URLComponents(string: baseURL+urlStringComponent)!
        urlComponent.queryItems = queryList
        urlComponent.queryItems?.append(appIDQueryItem)
        return urlComponent.url!
        
    }
    private init() {
        
    }

}


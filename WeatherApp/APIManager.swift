//
//  APIManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public class APIManager{
    
    private let appID = "0eb7a1c1573c34b2e8c005f3dcbd0201"
    static let shared: APIManager = APIManager()
    private var urlWeather : URLComponents!
    private var urlForecast : URLComponents!
    private var queryUnitItem = URLQueryItem(name: "units", value: "metric")
    private var queryCityItem = URLQueryItem(name: "q", value: "Chihuahua")
    private var appIDQueryItem : URLQueryItem!    
    var currentWeatherURL : URL!
    var forecastURL : URL!
    let session = URLSession(configuration: .default)
    let downloadSession = URLSession.shared
    
    private init(){
        
        appIDQueryItem = URLQueryItem(name: "APPID", value: appID)
        urlWeather = URLComponents(string:"http://api.openweathermap.org/data/2.5/weather")
        urlForecast = URLComponents(string:"http://api.openweathermap.org/data/2.5/forecast/daily")
        setQueryItemsList()
        currentWeatherURL = (urlWeather.url)!
        forecastURL = (urlForecast.url)!
        
    }
    func setQueryItem(forCityString city:String="", forDegreeUnit unit: TemperatureUnit = .defalt ){
        if city != ""{
            queryCityItem.value = city
        }
        if unit.rawValue != ""{
            queryUnitItem.value = unit.rawValue
        }
        setQueryItemsList()
        currentWeatherURL = (urlWeather.url)!
        forecastURL = (urlForecast.url)!
        print(currentWeatherURL)
    }
    
    private func setQueryItemsList(){
        urlWeather.queryItems = [appIDQueryItem,queryCityItem,queryUnitItem]
        urlForecast.queryItems = [appIDQueryItem,queryCityItem,queryUnitItem]
    }
    
}


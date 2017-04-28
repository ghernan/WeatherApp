//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class WeatherManager{
    private let service: WeatherService = WeatherService()
    func persistWeather(successHandler: @escaping (_ weather:Weather)->(), errorHandler: @escaping (_ error: Error)->()){
        service.getCurrentWeather(successHandler: { (dictionary) in
                                    successHandler(self.getParsedWeather(fromJSONDictionary: dictionary))
                                },
                                  errorHandler: {error in
                                    print("Error: \(error.localizedDescription)")
                                    errorHandler(error)
                                })
    }
    
    func persistForecast(successHandler: @escaping (_ forecast:[Weather])->(), errorHandler: @escaping (_ error: Error)->()){
        service.getForecast(successHandler: { (dictionary) in
            successHandler(self.getParsedForecast(fromJSONDictionary: dictionary))
        },
                                  errorHandler: {error in
                                    print("Error: \(error.localizedDescription)")
                                    errorHandler(error)
        })
    }
    private func getParsedForecast(fromJSONDictionary dict: JSONDictionary) -> [Weather]{
        var forecast : [Weather] = []
        guard let results = dict["list"] as? [Any]  else {
            print("Dictionary does not contain results key\n")
            return forecast
        }
        for weatherDict in results{
            guard let weatherDict = weatherDict as? JSONDictionary else{
                print("Could not parse JSON object")
                return forecast
            }
            guard let weatherJSONObj = weatherDict["temp"] as? JSONDictionary else{
                print("Dictionary does not contain results key")
                return forecast
            }
            forecast.append(Weather(withJSONForecast: weatherJSONObj))
        }

        return forecast
    }
    
    private func getParsedWeather(fromJSONDictionary dict: JSONDictionary) -> Weather{
        var weather : Weather!
        
        guard let weatherDictionary = dict["main"] as? JSONDictionary  else {
            print("Dictionary does not contain results key\n")
            return weather
        }
        weather = Weather(with: weatherDictionary)
        
        return(weather)
    }
    func setNewCity(withString city: String){
        service.setNewCity(withString: city)
    }
    func setDegreeUnit(withTempUnit unit:TemperatureUnit){
        service.setDegreeUnit(withTempUnit: unit)
    }

    

}

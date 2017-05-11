//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class WeatherManager{
    
    private let weatherService: WeatherService = WeatherService()
    
    //MARK: - Public methods
    
    func persistForecast(forCity cityString: String="", forTemperatureUnit unit: TemperatureUnit = .undef,successHandler: @escaping (_ forecast:[Weather])->(), errorHandler: @escaping (_ error: Error)->()){
        
        weatherService.getWeather(withWeatherInfo: .forecast,forCity:cityString, forTemperatureUnit: unit,
                                  successHandler: { (dictionary) in
            
                                    let forecast = self.getParsedForecast(fromJSONDictionary: dictionary)
                                    successHandler(forecast)
                                   
                                },
                                  errorHandler: {error in
                                    print("Error: \(error.localizedDescription)")
                                    errorHandler(error)
                                })
    }
    func persistCurrentWeather(forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .undef,successHandler: @escaping (_ weather:Weather?)->(), errorHandler: @escaping (_ error: Error)->()){
        
        weatherService.getWeather(withWeatherInfo: .current,forCity:cityString, forTemperatureUnit: unit,
                                  successHandler: { (dictionary) in
            
                                    let weather = self.getParsedWeather(fromJSONDictionary: dictionary)
                                    successHandler(weather)
                                            
                                },
                                  errorHandler: {error in
                                    print("Error: \(error.localizedDescription)")
                                    errorHandler(error)
                                })
    }
    
    //MARK: - Private methods
    
    private func getParsedForecast(fromJSONDictionary dict: JSONDictionary) -> [Weather] {
        var forecast : [Weather] = []
        guard let results = dict["list"] as? [JSONDictionary]  else {
            print("Dictionary does not contain results key\n")
            return forecast
        }
        for weatherDict in results {
            
            guard let weatherJSONObj = weatherDict["temp"] as? JSONDictionary else {
                print("Dictionary does not contain temp key")
                return forecast
            }
            guard let date = weatherDict["dt"] as? Int else {
                print("Dictionary does not contain dt key")
                return forecast
            }
            if let weather = try? Weather(withJSONForecast: weatherJSONObj, withUnixTimeStamp: date){
                forecast.append(weather)
            }
            
        }

        return forecast
    }
    
    private func getParsedWeather(fromJSONDictionary dict: JSONDictionary) -> Weather? {
        var weather : Weather!
        
        guard let weatherDictionary = dict["main"] as? JSONDictionary  else {
            print("Dictionary does not contain results key\n")
            return weather
        }
        if let currentWeather = try? Weather(with: weatherDictionary){
            weather = currentWeather
        }
        
        return weather
    }


    

}

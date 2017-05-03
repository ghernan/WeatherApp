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
    
    func persistWeather(withWeatherInfo type: WeatherInfoType,forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt,successHandler: @escaping (_ forecast:[Weather])->(), errorHandler: @escaping (_ error: Error)->()){
        
        weatherService.getWeather(withWeatherInfo: type,forCity:cityString, forDegreeUnit: unit, successHandler: { (dictionary) in
                                switch type{
                                case .current:
                                    if let weather = self.getParsedWeather(fromJSONDictionary: dictionary){
                                        successHandler([weather])
                                    }
                                    else{
                                        successHandler([])
                                    }
                                    
                                case .forecast:
                                    if let weather = self.getParsedForecast(fromJSONDictionary: dictionary){
                                        successHandler(weather)
                                    }
                                    else{
                                        successHandler([])
                                    }

            
                            }
            
                            },
                            errorHandler: {error in
                                print("Error: \(error.localizedDescription)")
                                errorHandler(error)
                            })
    }
    
    private func getParsedForecast(fromJSONDictionary dict: JSONDictionary) -> [Weather]?{
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
    
    private func getParsedWeather(fromJSONDictionary dict: JSONDictionary) -> Weather?{
        var weather : Weather!
        
        guard let weatherDictionary = dict["main"] as? JSONDictionary  else {
            print("Dictionary does not contain results key\n")
            return weather
        }
        weather = Weather(with: weatherDictionary)
        
        return(weather)
    }


    

}

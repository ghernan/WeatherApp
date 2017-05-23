//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class WeatherManager{
    
    private let weatherService: WeatherService = WeatherService()
    
    //MARK: - Public methods
    
    func persistForecast(forCity cityString: String="", forTemperatureUnit unit: TemperatureUnit = .undefined,successHandler: @escaping (_ forecast:[Weather])->(), errorHandler: @escaping (_ error: Error)->()){
        
        weatherService.getWeather(withWeatherInfo: .forecast,forCity:cityString, forTemperatureUnit: unit,
                                  successHandler: { (dictionary) in
            
                                    let forecast = self.getParsedForecast(fromJSONDictionary: dictionary, withTemperatureUnit: unit)
                                    successHandler(forecast)
                                   
                                },
                                  errorHandler: {error in
                                    print("Error: \(error.localizedDescription)")
                                    errorHandler(error)
                                })
    }
    func persistCurrentWeather(forCity cityString: String="", forTemperatureUnit unit: TemperatureUnit = .undefined,successHandler: @escaping (_ weather:Weather?)->(), errorHandler: @escaping (_ error: Error)->()){
        
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
    
    private func getParsedForecast(fromJSONDictionary dictionary: [String : Any], withTemperatureUnit unit: TemperatureUnit) -> [Weather] {
        
        guard let results = dictionary["list"] as? [[String : Any]] else {
            print("Dictionary does not contain results key\n")
            return []
        }
        if let forecast = Mapper<ForecastWeather>().mapArray(JSONArray: results) {
            return forecast
        }
        
        return []
    }
    
    private func getParsedWeather(fromJSONDictionary dictionary: [String : Any]) -> Weather? {        
        
        if let currentWeather =  Mapper<CurrentWeather>().map(JSON: dictionary) {
            return currentWeather
        }
        
        return nil
    }


    

}

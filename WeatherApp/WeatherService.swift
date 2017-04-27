//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class WeatherService{

    func getCurrentWeather(successHandler: @escaping (_ dict: JSONDictionary)->(), errorHandler:@escaping (_ error:Error)->()){
        let task = APIManager.shared.session.dataTask(with: APIManager.shared.currentWeatherURL) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                errorHandler(error!)
                return
            }
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONDictionary
                successHandler(dict)
            } catch let parseError as NSError {
                print("JSONSerialization error: \(parseError.localizedDescription)\n")
            }

        }
        task.resume()
    
    }
    
    func getForecast(successHandler: @escaping (_ dict: JSONDictionary)->(), errorHandler:@escaping (_ error:Error)->()){
        let task = APIManager.shared.session.dataTask(with: APIManager.shared.forecastURL) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                errorHandler(error!)
                return
            }
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONDictionary
                successHandler(dict)
            } catch let parseError as NSError {
                print("JSONSerialization error: \(parseError.localizedDescription)\n")
            }
            
        }
        task.resume()

        
    }
    func setNewCity(withString city: String){
        APIManager.shared.setQueryItem(forCityString: city)
    }
    func setDegreeUnit(withTempUnit unit:TemperatureUnit){
        APIManager.shared.setQueryItem(forDegreeUnit: unit )
    }



}

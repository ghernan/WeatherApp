//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class WeatherService{
    private let apiManager = APIManager.shared

    func getWeather(withWeatherInfo type: WeatherInfoType,forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt, successHandler: @escaping (_ dict: JSONDictionary)->(), errorHandler:@escaping (_ error:Error)->()){
        
        let task = APIManager.shared.session.dataTask(with: createURL(withWeatherInfo: type, forCity: cityString, forDegreeUnit: unit)) { (data, response, error) in
            
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

    private func createURL(withWeatherInfo type: WeatherInfoType, forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt)->URL{
        var urlWeatherComponents = URLComponents(string:(apiManager.baseURL+type.getURLStringComponent()))!
        urlWeatherComponents.queryItems = getURLWeatherQueryItemsList(forCity: cityString, forDegreeUnit: unit)
        return urlWeatherComponents.url!
    }
    
    private func getURLWeatherQueryItemsList(forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt) -> [URLQueryItem]{
        if cityString != ""{
            apiManager.queryCityItem.value = cityString
        }
        if unit.queryParameter() != ""{
            apiManager.queryUnitItem.value = unit.queryParameter()
        }
        return [apiManager.appIDQueryItem,apiManager.queryCityItem,apiManager.queryUnitItem]
    
    }



}

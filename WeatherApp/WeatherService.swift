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
    private var queryUnitItem = URLQueryItem(name: "units", value: "metric")
    private var queryCityItem = URLQueryItem(name: "q", value: "Chihuahua")
    
    
    func getWeather(withWeatherInfo type: WeatherInfoType,forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt, successHandler: @escaping (_ dict: JSONDictionary)->(), errorHandler:@escaping (_ error:Error)->()){
        
        let task = APIManager.shared.session.dataTask(with: createURL(withWeatherInfo: type, forCity: cityString, forDegreeUnit: unit)) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                errorHandler(error!)
                return
            }
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONDictionary
                successHandler(dict)
            } catch let parseError {
                print("JSONSerialization error: \(parseError.localizedDescription)\n")
                errorHandler(parseError)
            }
            
        }
        task.resume()
        
    }

    private func createURL(withWeatherInfo type: WeatherInfoType, forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt)->URL{
        let urlWeatherStringComponent = type.getURLStringComponent()
        let urlWeatherQueryList  = getURLWeatherQueryItemsList(forCity: cityString, forDegreeUnit: unit)
        return APIManager.shared.returnURL(fromURLStringComponent: urlWeatherStringComponent, withQueryItems: urlWeatherQueryList)
    }
    
    private func getURLWeatherQueryItemsList(forCity cityString: String="", forDegreeUnit unit: TemperatureUnit = .defalt) -> [URLQueryItem]{
        if cityString != ""{
            queryCityItem.value = cityString
        }
        if unit != .defalt{
            queryUnitItem.value = unit.queryParameter()
        }
        return [queryCityItem,queryUnitItem]
    
    }



}

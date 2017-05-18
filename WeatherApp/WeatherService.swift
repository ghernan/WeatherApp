//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import Alamofire

class WeatherService{
    
    private let apiManager = APIManager.shared
    private var queryUnitItem = URLQueryItem(name: "units", value: "metric")
    private var queryCityItem = URLQueryItem(name: "q", value: "Chihuahua")
    
    //MARK: - Public methods
    
    func getWeather(withWeatherInfo type: WeatherInfoType, forCity cityString: String="", forTemperatureUnit unit: TemperatureUnit = .undefined, successHandler: @escaping (_ dict: JSONDictionary)->(),  errorHandler:@escaping (_ error:Error)->()){
        
        Alamofire.request(createURL(withWeatherInfo: type, forCity: cityString, forTemperatureUnit: unit))
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    do {
                        let dict = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! JSONDictionary
                        successHandler(dict)
                    } catch let parseError {
                        print("JSONSerialization error: \(parseError.localizedDescription)\n")
                        errorHandler(parseError)
                    }

                case .failure(let error):
                    errorHandler(error)
                }
        }
    }
    
    //MARK: - Private methods

    private func createURL(withWeatherInfo type: WeatherInfoType, forCity cityString: String="", forTemperatureUnit unit: TemperatureUnit = .undefined) -> URL {
        let urlWeatherStringComponent = type.getURLStringComponent()
        let urlWeatherQueryList  = getURLWeatherQueryItemsList(forCity: cityString, forTemperatureUnit: unit)
        return apiManager.returnURL(fromURLStringComponent: urlWeatherStringComponent, withQueryItems: urlWeatherQueryList)
    }
    
    private func getURLWeatherQueryItemsList(forCity cityString: String="",  forTemperatureUnit unit: TemperatureUnit = .undefined) -> [URLQueryItem] {
        if cityString != ""{
            queryCityItem.value = cityString
        }
        if unit != .undefined{
            queryUnitItem.value = unit.queryParameter()
        }
        return [queryCityItem,queryUnitItem]
    
    }



}

//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Alamofire

enum WeatherRouter: URLRequestConvertible {
    
    private static let baseURLString = "http://api.openweathermap.org/data/2.5/"
    private static let apiKey = "0eb7a1c1573c34b2e8c005f3dcbd0201"
    
    case getWeatherData(withWeatherInfoType: WeatherInfoType, forCity: String , forTemperatureUnit: TemperatureUnit )
    
    
    var query: (path: String, parameters: Parameters) {
        switch self {
        case .getWeatherData(let type, let city, let unit):
            return (type.getURLStringComponent(),["APPID": WeatherRouter.apiKey,"q": city, "units": unit.queryParameter()])
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try WeatherRouter.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(query.path))
        return try URLEncoding.default.encode(urlRequest, with: query.parameters)
        
        
    }
}

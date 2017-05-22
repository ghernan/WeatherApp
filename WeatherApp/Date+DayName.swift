//
//  DateManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/27/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import ObjectMapper

extension Date{
    
    func dayName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone(abbreviation:"GMT")
        let dayName = formatter.string(from: self)
        
        return dayName == formatter.string(from: Date()) ? "Today" : dayName
    }
    
    static let dayStringName = TransformOf<String, Double>(fromJSON: { (value: Double?) -> String? in
        if let timeStamp = value {
            return Date(timeIntervalSince1970: value!).dayName()
        }
        return nil
        
    }, toJSON: { (value: String?) -> Double? in
        if let value = value {
            return Double(value)
        }
        return nil
    })
}

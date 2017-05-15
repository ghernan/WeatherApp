//
//  DateManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/27/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

extension Date{
    
    func dayName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone(abbreviation:"GMT")
        let dayName = formatter.string(from: self)
        
        return dayName == formatter.string(from: Date()) ? "Today" : dayName
    }
}

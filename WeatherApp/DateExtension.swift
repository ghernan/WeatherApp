//
//  DateManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/27/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

extension Date{
    
    func getDayName() -> String {        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self) == formatter.string(from: Date()) ? "Today" : formatter.string(from: self)
    }
}

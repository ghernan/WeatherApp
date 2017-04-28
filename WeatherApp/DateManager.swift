//
//  DateManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/27/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class DateManager{
    private var date = Date()
    private let formatter = DateFormatter()
    private var calendar =  Calendar(identifier: .gregorian)
    private var dateComponent = DateComponents()
        
    func getDayName(inDays days:Int)->String{
        dateComponent.day = days
        let newDate = calendar.date(byAdding: dateComponent, to: date)!
        formatter.dateFormat = "EEEE"
        return formatter.string(from: newDate)
    }
}

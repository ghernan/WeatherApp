//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/3/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell{
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    public static var reusableIdentifier: String{
        return String(describing: self)
    }
    
    
    func configureCell(withWeather weather: Weather) {
        
            maxTempLabel.text = "\(weather.maxTemp)\(weather.tempUnit.measureUnit())"
            minTempLabel.text = "\(weather.minTemp)\(weather.tempUnit.measureUnit())"
            dayLabel.text = weather.dateString
        
        
        
        
    }

}

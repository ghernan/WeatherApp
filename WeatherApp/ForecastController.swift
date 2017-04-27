//
//  ForecastController.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class ForecastController: UIViewController {
    private let manager: WeatherManager = WeatherManager()
    private var labelStack: [UILabel] = []
    
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var tomorrowLabel: UILabel!
    
    @IBOutlet weak var thirdDayLabel: UILabel!
    
    @IBOutlet weak var fourthDayLabel: UILabel!
    
    @IBOutlet weak var fifthDayLabel: UILabel!
    
    @IBOutlet weak var sixthDayLabel: UILabel!
    
    @IBOutlet weak var seventhDayLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setLabels()

    }
    func stackLabels(){
        labelStack=[
            todayLabel,
            tomorrowLabel,
            thirdDayLabel,
            fourthDayLabel,
            fifthDayLabel,
            sixthDayLabel,
            seventhDayLabel
        ]
    }
    func setTemperature(onLabel label: UILabel, with weather: Weather){
        label.text = "\(label.text!) \(weather.minTemp) / \(weather.maxTemp)"
    }
    func setLabels(){
        
        manager.persistForecast(successHandler: { (forecast) in
            
                                    DispatchQueue.main.async {
                                        self.stackLabels()
                                        for index in 0..<forecast.count{
                                            self.setTemperature(onLabel: self.labelStack[index], with: forecast[index])
                                        }
                                    }
                                },
                                errorHandler: {error in
                                print(error)
                                })
    }   
}

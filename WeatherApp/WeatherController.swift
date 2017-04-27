//
//  ViewController.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import CoreLocation

class WeatherController: UIViewController {
    let manager: WeatherManager = WeatherManager()
    var currrentLat = CLLocationDegrees()
    var currrentLong = CLLocationDegrees()
    var currentCity = String()
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    @IBAction func changeDegreeUnit(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            manager.setDegreeUnit(withTempUnit: .celcius)
            degreeLabel.text = "Celsius"
            break
        case 1:
            manager.setDegreeUnit(withTempUnit: .farenheit)
            degreeLabel.text = "Farenheit"
            break
        default:
            break
        }
        setLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        LocationManager.shared.delegate = self
    }
    func setTemperatureLabels(_ weather:Weather){
        tempLabel.text = "\(weather.currentTemp)"
        maxTempLabel.text = "\(weather.maxTemp)"
        minTempLabel.text = "\(weather.minTemp)"
    }
    func setLabels(){
        
        manager.persistWeather(successHandler: { (weather) in
                                                print(weather)
                                                DispatchQueue.main.async {
                                                        self.cityLabel.text = self.currentCity
                                                        self.locationLabel.text = "\(self.currrentLat), \(self.currrentLong)"
                                                        self.setTemperatureLabels(weather)
                                                }
            
            
            
                                                },
                                                errorHandler: {error in
                                                
                                                })
        
    
    }
}

extension WeatherController: LocationManagerDelegate{
    
    func locationDidUpdate(toLocation location: CLLocation, inCity: String) {
        if currentCity != inCity{
            currentCity = inCity
            currrentLat = location.coordinate.latitude
            currrentLong = location.coordinate.longitude
            manager.setNewCity(withString: currentCity)
            setLabels()
           
            
        }
        

    }
}


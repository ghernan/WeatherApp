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
    
    let manager = WeatherManager()
    var currrentLat = 0.0
    var currrentLong = 0.0
    var currentCity = ""
    var currentTempUnit = "°c"
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    @IBAction func toAppSettings(_ sender: Any) {
        LocationManager.shared.showLocationSettings()
    }
   
    
    @IBAction func changeDegreeUnit(_ sender: UISegmentedControl) {
        let unit = TemperatureUnit(rawValue: sender.selectedSegmentIndex)!
        manager.setDegreeUnit(withTempUnit: unit)
        currentTempUnit = unit.measureUnit()
        degreeLabel.text = unit.name()
        setLabels()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        LocationManager.shared.delegate = self
        LocationManager.shared.checkLocationServices(noAccess: { (alert) in
                                                        self.present(alert, animated: true, completion: {
                                                            
                                                        })
                                                    },
                                                     withAccess: {message in
                                                        print(message)
                                                    })
        
    }
    
    func setTemperatureLabels(_ weather:Weather){
        tempLabel.text = "\(weather.currentTemp)\(currentTempUnit)"
        maxTempLabel.text = "\(weather.maxTemp)\(currentTempUnit)"
        minTempLabel.text = "\(weather.minTemp)\(currentTempUnit)"
    }
    func setLabels(){
        
        manager.persistWeather(successHandler: { (weather) in
            
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


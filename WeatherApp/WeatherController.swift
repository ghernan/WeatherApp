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
    
    let weatherManager = WeatherManager()
    var currrentLat = 0.0
    var currrentLong = 0.0
    var currentCity = "Chihuahua"
    var tempUnit: TemperatureUnit = .celsius
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
        tempUnit = unit
        
        currentTempUnit = tempUnit.measureUnit()
        degreeLabel.text = tempUnit.name()
        setLabels()
    }
    override func viewDidAppear(_ animated: Bool) {
        LocationManager.shared.delegate = self
        checkLocationServicesStatus()
        
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkLocationServicesStatus), name: .UIApplicationDidBecomeActive, object: nil)
        
    }
    func checkLocationServicesStatus(){
        LocationManager.shared.checkLocationServices(
            noAccess: { (alert) in
                self.present(alert, animated: true, completion: {})
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
        
        weatherManager.persistCurrentWeather( forCity: currentCity, forDegreeUnit: tempUnit, successHandler: { (weather) in
            
                                                DispatchQueue.main.async {
                                                        self.cityLabel.text = self.currentCity
                                                        self.locationLabel.text = "\(self.currrentLat), \(self.currrentLong)"
                                                    if let weather = weather{
                                                        self.setTemperatureLabels(weather)
                                                    }
                                                        
                                                    
                                                }
            
            
            
                                                },
                                                errorHandler: {error in
                                                    print(error)
                                                })
        
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "mainToForecast":
            if let destination = segue.destination as? ForecastController{
                destination.currentCity = currentCity
                destination.tempUnit = tempUnit
                
            }
        default: break
        }
    }
}

extension WeatherController: LocationManagerDelegate{
    
    func locationDidUpdate(toLocation location: CLLocation, inCity: String) {
        if currentCity != inCity{
            
            currentCity = inCity
            
            currrentLat = location.coordinate.latitude
            currrentLong = location.coordinate.longitude            
            setLabels()
        }
    }
}


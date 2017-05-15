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
    
    private let weatherManager = WeatherManager()
    private let locationManager = LocationManager()
    
    private var tempUnit: TemperatureUnit = .celsius
    
    
    //MARK: - IBOutlets from UI
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    //MARK: - IBActions from UI Components
    
    @IBAction func toAppSettings(_ sender: Any) {
        AppSettingsHelper.navigateToLocationSettings()
    }
   
    
    @IBAction func changeDegreeUnit(_ sender: UISegmentedControl) {
        let unit = TemperatureUnit(rawValue: sender.selectedSegmentIndex)!
        tempUnit = unit
        
        degreeLabel.text = tempUnit.name()
        
    }
    
    
    //MARK: - Controller life cycle functions

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkLocationServicesStatus), name: .UIApplicationDidBecomeActive, object: nil)
        
        locationManager.startUpdating()
        locationManager.didUpdateLocation = { location, city in
            self.setLabels(forLocation: location, inCity: city)
        }
        
    
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "mainToForecast":
            if let destination = segue.destination as? ForecastController{
                
                destination.tempUnit = tempUnit
                
            }
        default: break
        }
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
        
    }
    
    
    //MARK: - Public methods
    func checkLocationServicesStatus(){
        locationManager.checkLocationServices(
            noAccess: { (alert) in
                self.present(alert, animated: true, completion: {})
        },
            withAccess: {message in
                print(message)
        })
    
    }
    
    func setLabels(forLocation location: CLLocation, inCity city: String){
        
        
        weatherManager.persistCurrentWeather( forCity: city, forTemperatureUnit: tempUnit, successHandler: { (weather) in
            
                                                DispatchQueue.main.async {
                                                        self.cityLabel.text = city
                                                    
                                                        self.locationLabel.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
                                                    if let weather = weather{
                                                        self.setTemperatureLabels(weather)
                                                    }
                                                        
                                                    
                                                }
            
            
            
                                                },
                                                errorHandler: {error in
                                                    print(error)
                                                })
        
    
    }
    //MARK: - Private methods
    fileprivate func setTemperatureLabels(_ weather:Weather){
        tempLabel.text = "\(weather.currentTemp!)\(tempUnit.measureUnit())"
        maxTempLabel.text = "\(weather.maxTemp!)\(tempUnit.measureUnit())"
        minTempLabel.text = "\(weather.minTemp!)\(tempUnit.measureUnit())"
    }
}



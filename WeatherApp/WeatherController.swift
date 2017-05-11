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
    
    private var tempUnit: TemperatureUnit = .celsius
    private var currentTempUnit = "°c"
    fileprivate var currrentLat = 0.0
    fileprivate var currrentLong = 0.0
    fileprivate var currentCity = "Chihuahua"
    
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
        currentTempUnit = tempUnit.measureUnit()
        degreeLabel.text = tempUnit.name()
        setLabels()
    }
    
    
    //MARK: - Controller life cycle functions
    override func viewDidAppear(_ animated: Bool) {
        
        LocationManager.shared.delegate = self
        
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkLocationServicesStatus), name: .UIApplicationDidBecomeActive, object: nil)
        LocationManager.shared.startUpdating()
        setLabels()
        
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
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    
    //MARK: - Public methods
    func checkLocationServicesStatus(){
        LocationManager.shared.checkLocationServices(
            noAccess: { (alert) in
                self.present(alert, animated: true, completion: {})
        },
            withAccess: {message in
                print(message)
        })
    
    }
    //MARK: - Private methods
    fileprivate func setTemperatureLabels(_ weather:Weather){
        tempLabel.text = "\(weather.currentTemp!)\(tempUnit.measureUnit())"
        maxTempLabel.text = "\(weather.maxTemp!)\(tempUnit.measureUnit())"
        minTempLabel.text = "\(weather.minTemp!)\(tempUnit.measureUnit())"
    }
    fileprivate func setLabels(){
        
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

}

//MARK: - LocationManagerDelegate

extension WeatherController: LocationManagerDelegate{
    
    func locationDidUpdate(toLocation location: CLLocation, inCity: String) {
        if currentCity != inCity {
            currentCity = inCity
            currrentLat = location.coordinate.latitude
            currrentLong = location.coordinate.longitude            
            setLabels()
        }
    }
}


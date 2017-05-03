//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import CoreLocation



class LocationManager: NSObject{
    static let shared : LocationManager = LocationManager()
    private let clManager = CLLocationManager()
    var currentLocation : CLLocation!
    var currentCity : String!
    var delegate : LocationManagerDelegate?
    
    private override init(){
        super.init()
        clManager.delegate = self
        clManager.desiredAccuracy = kCLLocationAccuracyBest
        clManager.requestAlwaysAuthorization()
        clManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = locations.last
        getLocationString(withLocation: self.currentLocation, successHandler: { (cityString) in
                                                                self.currentCity = cityString
            
                                                                DispatchQueue.main.async {
                                                                    self.delegate?.locationDidUpdate(toLocation: self.currentLocation, inCity: self.currentCity)
                                                              }
            
                                                              },
                                                              errorHandler: {error in
                                                                print(error)
                                                              })
        
    }
    
    
    private func getLocationString(withLocation location: CLLocation, successHandler: @escaping (_ cityString:String) -> (), errorHandler: @escaping (_ error: Error) -> ()) {
        
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            guard let placemark = placemarks?[0] else{
                print("Error: \(error!)")
                errorHandler(error!)
                return
            }
            if let city = placemark.locality{
                
                successHandler(city)
            }
        }
    }
    
    func showLocationSettings(){
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {            
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: { (didOpen) in
                print("to app settings")
                print(didOpen)
            })
        }
        else{
            print("could not go to settings")
        }
    }
    
    func checkLocationServices(noAccess: @escaping(_ alert:UIAlertController)->(), withAccess: @escaping(_ message:String)->()){
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                noAccess(notifyUser())
            case .authorizedAlways, .authorizedWhenInUse:
                withAccess("Weather App has been previously authorized for location services.")
            
                
            }
            
            
        } else {
            print("Location services are not enabled")
        }
    }
    
    private func notifyUser()->UIAlertController{
        let alert = UIAlertController(title: "Location",
                                      message: "Enabled location is needed for WeatherApp to work properly. You can change location services by tapping Settings button.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",style: .cancel){action in
            alert.dismiss(animated: true){}
        }
        let changeSettingsAction = UIAlertAction(title: "Go to Settings",style: .default){action in
            self.showLocationSettings()
        }
        alert.addAction(cancelAction)
        alert.addAction(changeSettingsAction)
        return alert
    }
}

//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate : class{
    
    func locationDidUpdate(toLocation location : CLLocation, inCity : String )

}

class LocationManager: NSObject {
    
    
    fileprivate var currentLocation : CLLocation!
    var currentLatitude = 0.0
    var currentLongitude = 0.0
    fileprivate var currentCity = "Chihuahua"
    var didUpdateLocation:((_ location: CLLocation, _ city: String) -> Void)?
    
    
    fileprivate weak var delegate : LocationManagerDelegate?
    
    private let coreLocationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    //MARK: - Public methods
    
    
    func startUpdating() {
        coreLocationManager.delegate = self
        coreLocationManager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        coreLocationManager.stopUpdatingLocation()
    }
    
    func checkLocationServices(noAccess: @escaping(_ alert:UIAlertController) -> (), withAccess: @escaping(_ message:String)->()) {
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                noAccess(notifyUser())
            case .authorizedAlways, .authorizedWhenInUse:
                withAccess("Weather App has been previously authorized for location services.")
            }
        }
        else {
            print("Location services are not enabled")
        }
    }
    
    //MARK: - Private methods
    
    fileprivate func notifyUser() -> UIAlertController {
        
        let alert = UIAlertController(title: "Enabled location is needed for WeatherApp to work properly.",
                                      message: "Chihuahua city will be used as default for demonstration purposes.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",style: .cancel){action in
            alert.dismiss(animated: true){}
        }
        
        let changeSettingsAction = UIAlertAction(title: "Go to Settings",style: .default){action in
            AppSettingsHelper.navigateToLocationSettings()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(changeSettingsAction)
        return alert
    }
    
     fileprivate func getReverseLocation(fromLocation location: CLLocation, successHandler: @escaping (_ cityString:String) -> (), errorHandler: @escaping (_ error: Error) -> ()) {
        
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
    

}

// MARK: - CLLocationManagerDelegate

extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = locations.last
        self.currentLatitude = self.currentLocation.coordinate.latitude
        self.currentLongitude = self.currentLocation.coordinate.longitude
        NotificationCenter.default.post(name: Notification.Name("locationUpdated"), object: self, userInfo: nil)
        getReverseLocation(fromLocation: self.currentLocation, successHandler: { (cityString) in
                                                                self.currentCity = cityString
                                              self.didUpdateLocation?(self.currentLocation, self.currentCity)
            
                                            },
                                                              errorHandler: {error in
                                                                print(error)
                                                              })
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            if let viewController =  UIApplication.shared.keyWindow?.rootViewController {
                notifyUser().show(viewController, sender: self)
            }
            
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
        } 
    }
    
    
    
}

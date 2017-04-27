//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import CoreLocation



class LocationManager: NSObject{
    static let shared : LocationManager = LocationManager()
    private let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var currentCity : String!
    var delegate : LocationManagerDelegate!
    
    private override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = locations.last
        getLocationString(withLocation: self.currentLocation, successHandler: { (cityString) in
                                                                self.currentCity = cityString
            
                                                                DispatchQueue.main.async {
                                                                    self.delegate.locationDidUpdate(toLocation: self.currentLocation, inCity: self.currentCity)
                                                              }
            
                                                              },
                                                              errorHandler: {error in
                                                                print(error)
                                                              })
        
    }
    
    func getLocationString(withLocation location: CLLocation, successHandler: @escaping (_ cityString:String) -> (), errorHandler: @escaping (_ error: Error) -> ()) {
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

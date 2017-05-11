//
//  AppSettingsHelper.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/11/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import UIKit

class AppSettingsHelper{

    static func navigateToLocationSettings() {
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
    


}

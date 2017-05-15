//
//  SerializationError.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 5/10/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public enum SerializationError: Error {
    case missing(message: String)    
}

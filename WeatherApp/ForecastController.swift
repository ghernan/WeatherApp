//
//  ForecastController.swift
//  WeatherApp
//
//  Created by Antonio  Hernandez  on 4/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import CoreLocation

class ForecastController: UIViewController {
    var forecast: [Weather] = []
    var tempUnit: TemperatureUnit = .undef
    var currentCity = ""
    private let weatherManager = WeatherManager()
    private var labelStack: [UILabel] = []
    

    //MARK: - IBOutlets from UI
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller life cycle functions
    
    override func viewDidAppear(_ animated: Bool) {
        LocationManager.shared.delegate = self
        navigationItem.title = currentCity
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        getForecast()
        

    }
    //MARK: - Private methods
    fileprivate func getForecast(){
        
        weatherManager.persistForecast( forCity: currentCity, forDegreeUnit: tempUnit, successHandler: { (forecast) in
            
                                    DispatchQueue.main.async {
                                        
                                        self.forecast = forecast
                                        for weather in self.forecast {
                                            weather.tempUnit = self.tempUnit
                                         
                                        }
                                        self.tableView.reloadData()
                                    }
                                },
                                errorHandler: {error in
                                print(error)
                                })
    }   
}

//MARK: - UITableViewDelegate
extension ForecastController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}

//MARK: - UITableViewDataSource
extension ForecastController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecast.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reusableIdentifier) as! ForecastCell
        let index = indexPath.row
        let weather = forecast[index]
        cell.configureCell(withWeather: weather )
        return cell
    }
    
}

//MARK: - LocationManagerDelegate

extension ForecastController: LocationManagerDelegate{
    
    func locationDidUpdate(toLocation location: CLLocation, inCity: String) {
        if currentCity != inCity{
            currentCity = inCity
            navigationItem.title = currentCity
            getForecast()
        }
    }
}



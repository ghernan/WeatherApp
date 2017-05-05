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
    let dateManager = DateManager()
    private let weatherManager = WeatherManager()
    private var labelStack: [UILabel] = []
    var forecast: [Weather] = []
    var tempUnit: TemperatureUnit = .defalt
    var currentCity = ""

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        LocationManager.shared.delegate = self
        navigationItem.title = currentCity
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        getForecast()
        

    }
    
    func getForecast(){
        
        weatherManager.persistForecast( forCity: currentCity, forDegreeUnit: tempUnit, successHandler: { (forecast) in
            
                                    DispatchQueue.main.async {
                                        
                                        self.forecast = forecast
                                        for index in 0..<self.forecast.count{
                                            self.forecast[index].tempUnit = self.tempUnit
                                            self.forecast[index].dateString = self.dateManager.getDayName(inDaysFromNow: index)
                                        }
                                        self.tableView.reloadData()
                                    }
                                },
                                errorHandler: {error in
                                print(error)
                                })
    }   
}
extension ForecastController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}

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
extension ForecastController: LocationManagerDelegate{
    
    func locationDidUpdate(toLocation location: CLLocation, inCity: String) {
        if currentCity != inCity{
            currentCity = inCity
            navigationItem.title = currentCity
            getForecast()
        }
    }
}



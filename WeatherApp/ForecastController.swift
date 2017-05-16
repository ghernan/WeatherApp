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
    
    var tempUnit: TemperatureUnit = .undefined
    
    //MARK: - Private attributes
    
    private let weatherManager = WeatherManager()
    private var labelStack: [UILabel] = []
    fileprivate var forecast: [Weather] = []
    fileprivate var locationManager = LocationManager()
    

    //MARK: - IBOutlets from UI
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller life cycle functions

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        locationManager.startUpdating()
        locationManager.didUpdateLocation = { [weak self] location, city in
            self?.getForecast(inCity: city)
            self?.navigationItem.title = city

        }
       
        
       

    }
    

    //MARK: - Public methods
    func getForecast( inCity city: String) {
        
        weatherManager.persistForecast( forCity: city, forTemperatureUnit: tempUnit, successHandler: { (forecast) in
            
                                    DispatchQueue.main.async {
                                        
                                        self.forecast = forecast
                                        self.navigationItem.title = city
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


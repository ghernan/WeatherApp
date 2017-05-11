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
    
    var tempUnit: TemperatureUnit = .undef
    
    private let weatherManager = WeatherManager()
    private var labelStack: [UILabel] = []
    fileprivate var forecast: [Weather] = []
    

    //MARK: - IBOutlets from UI
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller life cycle functions
    
    override func viewDidAppear(_ animated: Bool) {
        
        navigationItem.title = LocationManager.shared.currentCity
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(getForecast), name: Notification.Name("locationUpdated"), object: nil)
        getForecast()
       

    }
    deinit{
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("locationUpdated"), object: nil)
    }

    //MARK: - Public methods
    func getForecast() {
        
        weatherManager.persistForecast( forCity: LocationManager.shared.currentCity, forTemperatureUnit: tempUnit, successHandler: { (forecast) in
            
                                    DispatchQueue.main.async {
                                        
                                        self.forecast = forecast
                                        self.navigationItem.title = LocationManager.shared.currentCity
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


//
//  ViewController.swift
//  WeatherGift
//
//  Created by Tim Burns on 1/8/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var WeatherLocations: [WeatherLocation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var weatherLocation = WeatherLocation(name: "Preston, UK", latitude: 0, longitude: 0)
        WeatherLocations.append(weatherLocation)
        weatherLocation = WeatherLocation(name: "Belfast, UK", latitude: 0, longitude: 0)
        WeatherLocations.append(weatherLocation)
        weatherLocation = WeatherLocation(name: "Melbourne, FL", latitude: 0, longitude: 0)
        WeatherLocations.append(weatherLocation)
        
        tableView.dataSource = self
        tableView.delegate = self
        }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
     
}

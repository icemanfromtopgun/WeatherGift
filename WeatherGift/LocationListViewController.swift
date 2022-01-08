//
//  LocationListViewController.swift
//  WeatherGift
//
//  Created by Tim Burns on 1/8/22.
//

import UIKit

class LocationListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!

    
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
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = false
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
    }
    
    @IBAction func addLocationPressed(_ sender: UIBarButtonItem) {
    }
    
}

extension LocationListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = WeatherLocations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            WeatherLocations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        let itemToMove = WeatherLocations[sourceIndexPath.row]
        WeatherLocations.remove(at: sourceIndexPath.row)
        WeatherLocations.insert(itemToMove, at: destinationIndexPath.row)
    }
}

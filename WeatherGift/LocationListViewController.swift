//
//  LocationListViewController.swift
//  WeatherGift
//
//  Created by Tim Burns on 1/8/22.
//

import GooglePlaces
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
        let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self

//            // Specify the place data types to return.
//            let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//              UInt(GMSPlaceField.placeID.rawValue))!
//            autocompleteController.placeFields = fields
//
//            // Specify a filter.
//            let filter = GMSAutocompleteFilter()
//            filter.type = .address
//            autocompleteController.autocompleteFilter = filter

            // Display the autocomplete view controller.
            present(autocompleteController, animated: true, completion: nil)
    }
    
}

extension LocationListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = WeatherLocations[indexPath.row].name
        cell.detailTextLabel?.text = "Lat:\(WeatherLocations[indexPath.row].latitude),Long:\(WeatherLocations[indexPath.row].longitude)"
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

extension LocationListViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
      
    let newLocation = WeatherLocation(name: place.name ?? "Unknown Location", latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
    WeatherLocations.append(newLocation)
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}

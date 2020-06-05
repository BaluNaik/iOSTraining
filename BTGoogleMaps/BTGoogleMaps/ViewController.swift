//
//  ViewController.swift
//  BTGoogleMaps
//
//  Created by Balu Naik on 6/5/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

struct BTGooglePlace {
    var placeName = ""
    var placeID = ""
}

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var placeLabel: UILabel!
    var locationManager = CLLocationManager()
    //private var googleMap: GMSMapView!
    private var marker = GMSMarker()
    private var placesList = [BTGooglePlace]()
    
    lazy var filter: GMSAutocompleteFilter = {
        let filter = GMSAutocompleteFilter()
        filter.country = "AE"
        
        return filter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.googleMap = GMSMapView(frame: self.mapView.bounds)
        //self.view.addSubview(self.googleMap)
        self.setUpMap()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.tableview.isHidden = true
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        } else if status == .denied || status == .restricted {
            self.showLocationSetUpAlert()
        } else {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Private
    
    private func setUpMap() {
        let defaultLocation = CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)
        self.googleMap.animate(toLocation: defaultLocation)
        self.googleMap.animate(toZoom: 15.0)
        self.googleMap.settings.myLocationButton = true
        self.googleMap.isMyLocationEnabled = true
        self.moveMarker(to: defaultLocation)
        self.googleMap.delegate = self
        //self.googleMap.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }
    
    private func moveMarker(to location:CLLocationCoordinate2D) {
        self.marker.position = location
        marker.map = googleMap
        self.validateLocation(location: location)
    }
    
    private func updateMarketInfo(locality: String, subLocality: String) {
        self.marker.title = subLocality
        self.marker.snippet = locality
        self.googleMap.selectedMarker = self.marker
    }
    
    private func showLocationSetUpAlert() {
        let alert = UIAlertController(title: "Error", message: "Change location setting", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "settings", style: .default) { (okAction) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: self.convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .default) { (cancelAction) in}
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    
    private func validateLocation(location: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) {[weak self] (placemarker, error) in
            guard let currentPlace = placemarker?.first else {
                
                return
            }
            // Here we can implement geo blocker like pointer loaction outside of country bounds
            if currentPlace.isoCountryCode != "AE" {
                
                return
            }
            self?.reverseGeoCoder(coordinate: location)
        }
        
    }
    
    private func reverseGeoCoder(coordinate: CLLocationCoordinate2D) {
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(coordinate) {[weak self] (response, error) in
            guard let address = response?.results()?.first else {
                
                return
            }
            DispatchQueue.main.async {
                self?.updateMarketInfo(locality: address.locality ?? "", subLocality: address.subLocality ?? "")
                self?.placeLabel.text = "\(address.thoroughfare ?? "") \(address.subLocality ?? "") \(address.locality ?? "") \(address.country ?? "")"
            }
            // Here we will get GMSAddress type
            print(address)
        }
    }
    
    private func fetchPlacesSuggestions(text: String) {
        GMSPlacesClient.shared().autocompleteQuery(text, bounds: nil, filter: filter) {[weak self] (result, error) in
            if error == nil && result != nil {
                if let resultArray = result {
                    var placesArray: [BTGooglePlace] = []
                    for place in resultArray {
                        if !(place.placeID.isEmpty) {
                            placesArray.append(BTGooglePlace(placeName: place.attributedPrimaryText.string, placeID: place.placeID))
                        }
                    }
                    DispatchQueue.main.async {
                        self?.updateList(list: placesArray)
                    }
                } else {
                    self?.tableview.isHidden = true
                }
            } else {
                self?.tableview.isHidden = true
                
                return
            }
        }
    }
    
    private func updateList(list: [BTGooglePlace]) {
        if list.isEmpty {
            self.placesList = []
            self.tableview.isHidden = true
        } else {
            self.placesList = list
            self.tableview.isHidden = false
            self.tableview.reloadData()
        }
    }
    
}


// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.desiredAccuracy = kCLLocationAccuracyKilometer
            manager.distanceFilter = 500
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        manager.stopUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0, zoom: 15.0)
        self.googleMap.animate(to: camera)
        if let coordinate = location?.coordinate {
            self.moveMarker(to: coordinate)
        }
    }
    
}


// MARK: - GMSMapViewDelegate

extension ViewController: GMSMapViewDelegate {
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        
        return true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.marker.title = ""
        self.marker.snippet = ""
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
         self.marker.position = position.target
        self.validateLocation(location: position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.marker.position = position.target
        self.validateLocation(location: position.target)
    }
    
    
}


// MARK: - UISearchBarDelegate, UITableViewDelegate & UITableViewDataSource

extension ViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.fetchPlacesSuggestions(text: searchText)
        } else {
            self.updateList(list: [])
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.placesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.placesList[indexPath.row].placeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.placesList[indexPath.row]
        
        //TODO:
    }
    
}

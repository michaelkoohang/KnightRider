//
//  FindController.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftKeychainWrapper

class FindController: UITableViewController {
    
    var rides = [Ride]()
    var filteredRides = [Ride]()
    var coordinate = CLLocationCoordinate2D()
    var UID = KeychainWrapper.standard.string(forKey: UID_KEY)
    var TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)
    let coder = CLGeocoder()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Find Rides"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        tableView.rowHeight = 215
        tableView.separatorStyle = .none
        tableView.register(RideCell.self, forCellReuseIdentifier: "ridecell")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Where to?"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barStyle = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = true
        fetchRides()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredRides.count
        }
        return rides.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ridecell") as? RideCell {
            let ride: Ride
            if isFiltering() {
                ride = filteredRides[indexPath.row]
            } else {
                ride = rides[indexPath.row]
            }

            cell.passengers.removeAll()
            cell.passengers.append(ride.driver)
            for passenger in ride.passengers {
                cell.passengers.append(passenger)
            }
            
            cell.joinButton.addTarget(self, action: #selector(join(sender:)), for: .touchUpInside)
            cell.joinButton.tag = indexPath.row
            cell.configureCell(ride: ride)
            return cell
        } else {
            print("I've been called.")
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.ride = rides[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func fetchRides() {
        
        rides.removeAll()
        filteredRides.removeAll()
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(ALL_TRIPS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            if let array = response.result.value as? [Dictionary<String, AnyObject>] {
                print(response.debugDescription)
                for obj in array {
                    let ride = Ride(ridesDict: obj)

                    if !(ride.passengers.contains(where: { (passenger) -> Bool in
                        passenger.id == Int(self.UID!)
                    })) && ride.driverId != Int(self.UID!) {
                        self.rides.append(ride)
                    } 
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func join(sender: UIButton) {
        
        let spinner = FindController.displaySpinner(onView: self.tableView)
        
        let rideId: Int
        let address = KeychainWrapper.standard.string(forKey: ADDRESS_KEY)
        convertAddress(address: address!)
        
        if isFiltering() {
            rideId = filteredRides[sender.tag].id
        } else {
            rideId = rides[sender.tag].id
        }
        
        let parameters: Parameters = [
            "address": address!,
            "latitude": self.coordinate.latitude,
            "longitude": self.coordinate.longitude,
            "userId": UID!,
            "tripId": rideId
        ]

        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]

        Alamofire.request(PASSENGERS_URL + "\(rideId)/\(UID!)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in

            print(response.debugDescription)

            if let dict = response.result.value as? Dictionary<String, AnyObject> {

                if let message = dict["message"] as? String {

                    if message == "Successfully added!" {
                        FindController.removeSpinner(spinner: spinner)

                        let alert = UIAlertController(title: "You have joined this ride.", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)

                        self.fetchRides()
                    }

                } else {
                    FindController.removeSpinner(spinner: spinner)
                    
                    let alert = UIAlertController(title: "Server error. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                    }))

                    self.present(alert, animated: true, completion: nil)

                }

            }

        }
    }
    
    func convertAddress(address: String) {
        coder.geocodeAddressString(address) { (response, error) in
            let latitude = (response?[0].location?.coordinate.latitude)!
            let longitude = (response?[0].location?.coordinate.longitude)!
            self.coordinate.latitude = latitude
            self.coordinate.longitude = longitude
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRides = rides.filter({( ride : Ride) -> Bool in
            return ride.destCity.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}

extension FindController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

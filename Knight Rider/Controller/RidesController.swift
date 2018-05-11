//
//  HomeController.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class RidesController: UITableViewController {
    
    var rides = [Ride]()
    var UID = KeychainWrapper.standard.string(forKey: UID_KEY)
    var TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Rides"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        tableView.rowHeight = 215
        tableView.separatorStyle = .none
        tableView.register(RideCell.self, forCellReuseIdentifier: "ridecell")
        print("THIS IS MY UID = " + UID!)
        fetchUserInfo()
    }

    override func viewDidAppear(_ animated: Bool) {
        fetchRides()
    }
    
    func fetchUserInfo() {
        print("HI I AHAVE BEEN CALLED")
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(USER_URL + "\(UID!)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { (response) in
                        
            if let user = response.result.value as? Dictionary<String, AnyObject> {
                if let address = user["address"] as? String {
                    print("This is the address = " + address)
                    KeychainWrapper.standard.set(address, forKey: ADDRESS_KEY)
                }
            }
            
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ridecell") as? RideCell {
            let ride = rides[indexPath.row]
            
            cell.passengers.removeAll()
            cell.passengers.append(ride.driver)
            for passenger in ride.passengers {
                cell.passengers.append(passenger)
            }
            
            cell.messagesButton.tag = indexPath.row
            cell.leaveButton.tag = indexPath.row
            cell.deleteButton.tag = indexPath.row
            cell.messagesButton.addTarget(self, action: #selector(viewMessages), for: .touchUpInside)
            cell.leaveButton.addTarget(self, action: #selector(leaveRide), for: .touchUpInside)
            cell.deleteButton.addTarget(self, action: #selector(deleteRide), for: .touchUpInside)
            
            cell.configureCell(ride: ride)
            return cell
        } else {
            return RideCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.ride = rides[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func fetchRides() {
        rides.removeAll()
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(RIDES_URL + "\(UID!)/trips", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            print(response.debugDescription)
            if let array = response.result.value as? [Dictionary<String, AnyObject>] {
                for obj in array {
                    let ride = Ride(ridesDict: obj)
                    self.rides.append(ride)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func leaveRide(sender: UIButton) {
        
        let spinner = RidesController.displaySpinner(onView: self.tableView)
        
        let rideId = rides[sender.tag].id
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]

        Alamofire.request(PASSENGERS_URL + "\(rideId)/\(UID!)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { (response) in

            if let dict = response.result.value as? Dictionary<String, AnyObject> {

                if let message = dict["message"] as? String {

                    if message == "Successfully deleted!" {
                        RidesController.removeSpinner(spinner: spinner)

                        let alert = UIAlertController(title: "You have left this ride.", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)

                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))

                        self.present(alert, animated: true, completion: nil)

                        self.fetchRides()
                    }

                } else {
                    RidesController.removeSpinner(spinner: spinner)

                    let alert = UIAlertController(title: "Server error. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                    }))

                    self.present(alert, animated: true, completion: nil)

                }

            }
        }
        
    }
    
    @objc func deleteRide(sender: UIButton) {
        
        let spinner = RidesController.displaySpinner(onView: self.tableView)

        let rideId = rides[sender.tag].id

        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(DELETE_TRIP_URL + "\(rideId)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let message = dict["message"] as? String {
                    
                    if message == "Successfully deleted!" {
                        RidesController.removeSpinner(spinner: spinner)
                        
                        let alert = UIAlertController(title: "Ride deleted.", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        self.fetchRides()
                    }
                    
                } else {
                    RidesController.removeSpinner(spinner: spinner)
                    
                    let alert = UIAlertController(title: "Server error. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }
        
    }
    
    @objc func viewMessages(sender: UIButton) {
        let messages = MessageController()
        messages.ride = rides[sender.tag]
        self.navigationController?.pushViewController(messages, animated: true)
    }

}


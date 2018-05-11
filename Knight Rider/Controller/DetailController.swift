//
//  DetailController.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class DetailController: UIViewController, MKMapViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var scrollView: UIScrollView!
    var travelLabel: UILabel!
    var separator1: UIView!
    
    var departureLabel: UILabel!
    var departure: UILabel!
    var separator2: UIView!
    
    var mapLabel: UILabel!
    var mapWindow: MKMapView!
    var separator3: UIView!
    
    var driverLabel: UILabel!
    var driverPicture: ProfileCircleView!
    var driverFirstName: UILabel!
    var driverLastName: UILabel!
    var separator4: UIView!
    
    var passengerLabel: UILabel!
    var layout: UICollectionViewFlowLayout!
    var passengerView: UICollectionView!
    var separator5: UIView!
    
    var carLabel: UILabel!
    var carDescription: UILabel!
    var seatsRemainingLabel: UILabel!
    var seatsRemaining: UILabel!
    
    var ride: Ride!
    var origin: CLLocationCoordinate2D!
    var destination: CLLocationCoordinate2D!
    var originPlacemark: MKPlacemark!
    var destinationPlacemark: MKPlacemark!
    var directionRequest: MKDirectionsRequest!
    var directions: MKDirections!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        setupView()
    }

    func setupView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        scrollView.backgroundColor = .white
        
        travelLabel = UILabel()
        travelLabel.translatesAutoresizingMaskIntoConstraints = false
        travelLabel.font = UIFont(name: "Roboto-Bold", size: 20)
        travelLabel.text = ride.originCity + " to " + ride.destCity
        
        separator1 = UIView()
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.backgroundColor = .lightGray
        
        departureLabel = UILabel()
        departureLabel.translatesAutoresizingMaskIntoConstraints = false
        departureLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        departureLabel.text = "Departure"
        departureLabel.textColor = UIColor.gray
        
        departure = UILabel()
        departure.translatesAutoresizingMaskIntoConstraints = false
        departure.font = UIFont(name: "Roboto-Bold", size: 18)
        departure.text = ride.departureTime
        
        separator2 = UIView()
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.backgroundColor = .lightGray
        
        mapLabel = UILabel()
        mapLabel.translatesAutoresizingMaskIntoConstraints = false
        mapLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        mapLabel.text = "Map"
        mapLabel.textColor = UIColor.gray
        
        mapWindow = MKMapView()
        mapWindow.translatesAutoresizingMaskIntoConstraints = false
        origin = CLLocationCoordinate2D(latitude: ride.originLatitude, longitude: ride.originLongitude)
        destination = CLLocationCoordinate2D(latitude: ride.destLatitude, longitude: ride.destLongitude)
        originPlacemark = MKPlacemark(coordinate: origin)
        destinationPlacemark = MKPlacemark(coordinate: destination)
        directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: originPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        directions = MKDirections(request: directionRequest)
        directions.calculate { (response, err) in
            guard let directionResponse = response else {
                if let error = err {
                    print("Error getting directions." + "\n\(error)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.mapWindow.add(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapWindow.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        mapWindow.delegate = self
        
        separator3 = UIView()
        separator3.translatesAutoresizingMaskIntoConstraints = false
        separator3.backgroundColor = .lightGray
        
        driverLabel = UILabel()
        driverLabel.translatesAutoresizingMaskIntoConstraints = false
        driverLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        driverLabel.text = "Driver"
        driverLabel.textColor = UIColor.gray
        
        driverPicture = ProfileCircleView()
        driverPicture.translatesAutoresizingMaskIntoConstraints = false
        driverPicture.layer.borderColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1).cgColor
        if ride.driver.profilePicture != "" {
            let profilePictureURL = URL(string: ride.driver.profilePicture)
            Alamofire.request(profilePictureURL!).responseImage { response in
                if let image = response.result.value {
                    print(response.debugDescription)
                    self.driverPicture.image = image
                }
            }
        } else {
            self.driverPicture.image = UIImage(named: "avatar.png")
        }
        
        driverFirstName = UILabel()
        driverFirstName.translatesAutoresizingMaskIntoConstraints = false
        driverFirstName.font = UIFont(name: "Roboto-Bold", size: 22)
        driverFirstName.text = ride.driver.firstName
        
        driverLastName = UILabel()
        driverLastName.translatesAutoresizingMaskIntoConstraints = false
        driverLastName.font = UIFont(name: "Roboto-Bold", size: 22)
        driverLastName.text = ride.driver.lastName
        
        separator4 = UIView()
        separator4.translatesAutoresizingMaskIntoConstraints = false
        separator4.backgroundColor = .lightGray
        
        passengerLabel = UILabel()
        passengerLabel.translatesAutoresizingMaskIntoConstraints = false
        passengerLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        passengerLabel.text = "Passengers"
        passengerLabel.textColor = UIColor.gray
        
        layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 7.5, left: 28, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        passengerView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        passengerView.translatesAutoresizingMaskIntoConstraints = false
        passengerView.dataSource = self
        passengerView.delegate = self
        passengerView.register(PassengerCell.self, forCellWithReuseIdentifier: "passengerCell")
        passengerView.backgroundColor = .white
        
        separator5 = UIView()
        separator5.translatesAutoresizingMaskIntoConstraints = false
        separator5.backgroundColor = .lightGray
        
        carLabel = UILabel()
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        carLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        carLabel.text = "Car"
        carLabel.textColor = UIColor.gray
        
        carDescription = UILabel()
        carDescription.translatesAutoresizingMaskIntoConstraints = false
        carDescription.font = UIFont(name: "Roboto-Bold", size: 18)
        carDescription.text = ride.car.maker + " " + ride.car.type
        
        seatsRemainingLabel = UILabel()
        seatsRemainingLabel.translatesAutoresizingMaskIntoConstraints = false
        seatsRemainingLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        seatsRemainingLabel.text = "Seats Remaining"
        seatsRemainingLabel.textColor = UIColor.gray
        
        seatsRemaining = UILabel()
        seatsRemaining.translatesAutoresizingMaskIntoConstraints = false
        seatsRemaining.font = UIFont(name: "Roboto-Bold", size: 18)
        seatsRemaining.text = "\(ride.remainingSeats)"
        
        scrollView.addSubview(travelLabel)
        scrollView.addSubview(separator1)
        scrollView.addSubview(departureLabel)
        scrollView.addSubview(departure)
        scrollView.addSubview(separator2)
        scrollView.addSubview(mapLabel)
        scrollView.addSubview(mapWindow)
        scrollView.addSubview(separator3)
        scrollView.addSubview(driverLabel)
        scrollView.addSubview(driverPicture)
        scrollView.addSubview(driverFirstName)
        scrollView.addSubview(driverLastName)
        scrollView.addSubview(separator4)
        scrollView.addSubview(passengerLabel)
        scrollView.addSubview(passengerView)
        scrollView.addSubview(separator5)
        scrollView.addSubview(carLabel)
        scrollView.addSubview(carDescription)
        scrollView.addSubview(seatsRemainingLabel)
        scrollView.addSubview(seatsRemaining)

        view.addSubview(scrollView)
        setupConstraints()
    }
    
    func setupConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        travelLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        travelLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 28).isActive = true
        travelLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        travelLabel.widthAnchor.constraint(equalToConstant: 150)
        
        separator1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator1.topAnchor.constraint(equalTo: travelLabel.bottomAnchor, constant: 24).isActive = true
        separator1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        separator1.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        departureLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 18).isActive = true
        departureLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        departureLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        departureLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        departure.topAnchor.constraint(equalTo: departureLabel.bottomAnchor, constant: 8).isActive = true
        departure.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        departure.widthAnchor.constraint(equalToConstant: 200).isActive = true
        departure.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        separator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator2.topAnchor.constraint(equalTo: departure.bottomAnchor, constant: 18).isActive = true
        separator2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        separator2.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mapLabel.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 18).isActive = true
        mapLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        mapLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mapLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        mapWindow.topAnchor.constraint(equalTo: mapLabel.bottomAnchor, constant: 8).isActive = true
        mapWindow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        mapWindow.heightAnchor.constraint(equalToConstant: 300).isActive = true
        mapWindow.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28).isActive = true
        
        separator3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator3.topAnchor.constraint(equalTo: mapWindow.bottomAnchor, constant: 36).isActive = true
        separator3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        separator3.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        driverLabel.topAnchor.constraint(equalTo: separator3.bottomAnchor, constant: 18).isActive = true
        driverLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        driverLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        driverLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        driverPicture.topAnchor.constraint(equalTo: driverLabel.bottomAnchor, constant: 8).isActive = true
        driverPicture.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        driverPicture.widthAnchor.constraint(equalToConstant: 70).isActive = true
        driverPicture.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        driverFirstName.topAnchor.constraint(equalTo: driverPicture.topAnchor, constant: 6).isActive = true
        driverFirstName.leftAnchor.constraint(equalTo: driverPicture.rightAnchor, constant: 16).isActive = true
        driverFirstName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        driverFirstName.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        driverLastName.bottomAnchor.constraint(equalTo: driverPicture.bottomAnchor, constant: -6).isActive = true
        driverLastName.leftAnchor.constraint(equalTo: driverPicture.rightAnchor, constant: 16).isActive = true
        driverLastName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        driverLastName.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        separator4.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator4.topAnchor.constraint(equalTo: driverPicture.bottomAnchor, constant: 18).isActive = true
        separator4.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        separator4.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        passengerLabel.topAnchor.constraint(equalTo: separator4.bottomAnchor, constant: 18).isActive = true
        passengerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        passengerLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        passengerLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        passengerView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        passengerView.topAnchor.constraint(equalTo: passengerLabel.bottomAnchor, constant: 8).isActive = true
        passengerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        passengerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        separator5.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator5.topAnchor.constraint(equalTo: passengerView.bottomAnchor, constant: 18).isActive = true
        separator5.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        separator5.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        carLabel.topAnchor.constraint(equalTo: separator5.bottomAnchor, constant: 18).isActive = true
        carLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        carLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        carLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        carDescription.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 8).isActive = true
        carDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        carDescription.widthAnchor.constraint(equalToConstant: 200).isActive = true
        carDescription.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        seatsRemainingLabel.topAnchor.constraint(equalTo: separator5.bottomAnchor, constant: 18).isActive = true
        seatsRemainingLabel.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        seatsRemainingLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        seatsRemainingLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        seatsRemaining.topAnchor.constraint(equalTo: seatsRemainingLabel.bottomAnchor, constant: 8).isActive = true
        seatsRemaining.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        seatsRemaining.widthAnchor.constraint(equalToConstant: 50).isActive = true
        seatsRemaining.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 99/255, green: 243/255, blue: 147/255, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ride.passengers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = passengerView.dequeueReusableCell(withReuseIdentifier: "passengerCell", for: indexPath) as? PassengerCell {
            if indexPath.row == 0 {
                cell.profileFrame.layer.borderColor = UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1).cgColor
            }
            cell.configureCell(passenger: ride.passengers[indexPath.row])
            return cell
        } else {
            return PassengerCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    @objc func navigate() {
        //Navigate ride in Apple Maps.
    }

}

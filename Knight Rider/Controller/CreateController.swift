//
//  CreateController.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftKeychainWrapper

class CreateController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var cars = [Car]()
    var campuses = ["Macon Campus", "Cochran Campus", "Eastman Campus", "Warner Robins Campus", "Dublin Campus"]
    var originPressed = false
    var destinationPressed = false
    var carPressed = false
    
    var originCity: String!
    var destCity: String!
    var timeStamp: Double!
    var carId: Int!
    var availableSeats: Int!
    var originAddress: String!
    var destinationAddress: String!
    
    var UID = KeychainWrapper.standard.string(forKey: UID_KEY)
    var TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)
    
    let datePickerView = UIDatePicker()
    let carPickerView = UIPickerView()
    let campusPickerView = UIPickerView()
    
    let coder = CLGeocoder()
    var originCoordinate = CLLocationCoordinate2D()
    var destCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Rides"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()

        carPickerView.delegate = self
        campusPickerView.delegate = self
        originTextField.inputView = campusPickerView
        destinationTextField.inputView = campusPickerView
        carTextField.inputView = carPickerView
        
        originTextField.addTarget(self, action: #selector(originEditing), for: .editingDidBegin)
        originTextField.addTarget(self, action: #selector(convertOriginAddress), for: .editingDidEnd)
        destinationTextField.addTarget(self, action: #selector(destinationEditing), for: .editingDidBegin)
        destinationTextField.addTarget(self, action: #selector(convertDestAddress), for: .editingDidEnd)
        departureTextField.addTarget(self, action: #selector(departureEditing), for: .editingDidBegin)
        carTextField.addTarget(self, action: #selector(carEditing), for: .editingDidBegin)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadCarsData()
    }

    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let originTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Origin"
        tf.keyboardType = UIKeyboardType.emailAddress
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(originEditing(sender:)), for: .editingDidBegin)
        return tf
    }()
    
    let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let destinationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Destination"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(destinationEditing(sender:)), for: .editingDidBegin)
        return tf
    }()
    
    let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let departureTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Departure"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let carTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Car"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(carEditing(sender:)), for: .editingDidBegin)
        return tf
    }()
    
    func setupInputsContainerView() {
        
        inputsContainerView.addSubview(originTextField)
        inputsContainerView.addSubview(destinationTextField)
        inputsContainerView.addSubview(departureTextField)
        inputsContainerView.addSubview(carTextField)
        inputsContainerView.addSubview(separatorView1)
        inputsContainerView.addSubview(separatorView2)
        inputsContainerView.addSubview(separatorView3)
        
        inputsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        originTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        originTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        originTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        originTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        separatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView1.topAnchor.constraint(equalTo: originTextField.bottomAnchor, constant: 0).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        destinationTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        destinationTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        destinationTextField.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 0).isActive = true
        destinationTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        separatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView2.topAnchor.constraint(equalTo: destinationTextField.bottomAnchor, constant: 0).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        departureTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        departureTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        departureTextField.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 0).isActive = true
        departureTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        separatorView3.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView3.topAnchor.constraint(equalTo: departureTextField.bottomAnchor, constant: 0).isActive = true
        separatorView3.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        carTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        carTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        carTextField.topAnchor.constraint(equalTo: separatorView3.bottomAnchor, constant: 0).isActive = true
        carTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    func setupCreateButton() {
        createButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        createButton.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 0).isActive = true
        createButton.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: 0).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        createButton.addTarget(self, action: #selector(create), for: .touchUpInside)
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.addSubview(inputsContainerView)
        view.addSubview(createButton)
        setupInputsContainerView()
        setupCreateButton()
    }
    
    func downloadCarsData() {
        
        cars.removeAll()
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(CARS_URL + "\(UID!)/cars", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            if let array = response.result.value as? [Dictionary<String, AnyObject>] {
                for obj in array {
                    let car = Car(carsDict: obj)
                    self.cars.append(car)
                }
            }
        }
        
    }
    
    @objc func originEditing(sender:UITextField) -> Void {
        originTextField.text = campuses[0]
        originPressed = true
        destinationPressed = false
        sender.inputView = campusPickerView}
    
    @objc func destinationEditing(sender:UITextField) -> Void {
        destinationTextField.text = campuses[0]
        destinationPressed = true
        originPressed = false
        sender.inputView = campusPickerView
    }
    
    @objc func departureEditing(sender: UITextField) {
        datePickerView.datePickerMode = .dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func carEditing(sender:UITextField) -> Void {
        
        if cars.count < 1 {
            let alert = UIAlertController(title: "You must have a car registered in your profile before you can create rides.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
                self.view.endEditing(true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if (cars.count == 1) {
            carTextField.text = cars[0].maker + " " + cars[0].type
            carId = cars[0].id
            availableSeats = cars[0].capacity
        }
        
        destinationPressed = false
        originPressed = false
        carPressed = true
        sender.inputView = carPickerView
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY " + "-" + " h:mm a"
        departureTextField.text = dateFormatter.string(from: sender.date)
        timeStamp = self.datePickerView.date.timeIntervalSince1970
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if originPressed || destinationPressed {
            return campuses.count
        } else {
            return cars.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if originPressed || destinationPressed {
            return campuses[row]
        } else {
            return cars[row].maker + " " + cars[row].type
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if originPressed {
            originTextField.text = campuses[pickerView.selectedRow(inComponent: 0)]
        } else if destinationPressed {
            destinationTextField.text = campuses[pickerView.selectedRow(inComponent: 0)]
        } else {
            carTextField.text = cars[pickerView.selectedRow(inComponent: 0)].maker + " " + cars[pickerView.selectedRow(inComponent: 0)].type
            carId = cars[pickerView.selectedRow(inComponent: 0)].id
            availableSeats = cars[pickerView.selectedRow(inComponent: 0)].capacity
        }
    }
    
    
    
    @objc func create() {
        
        self.view.endEditing(true)
        
        if originTextField.text != "" && destinationTextField.text != "" && departureTextField.text != "" && carTextField.text != "" {
            
            let rideParameters: Parameters = [
                "carId": self.carId,
                "driverId": self.UID!,
                "originAddress": self.originAddress,
                "originCity": self.originCity,
                "originLatitude": self.originCoordinate.latitude,
                "originLongitude": self.originCoordinate.longitude,
                "destAddress": self.destinationAddress,
                "destCity": self.destCity,
                "destLatitude": self.destCoordinate.latitude,
                "destLongitude": self.destCoordinate.longitude,
                "departureTime": self.timeStamp * 1000,
                "meetingLocation": self.originCity,
                "availableSeats": self.availableSeats
            ]
            
            let tokenHeaders: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Authorization": "Bearer \(TOKEN!)",
                "Cache-Control": "no-cache"
            ]
            
            Alamofire.request(RIDES_URL + "\(UID!)/trips", method: .post, parameters: rideParameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
                
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let message = dict["message"] as? String {
                        
                        if message == "Successfully created!" {
                            
                            let alert = UIAlertController(title: "Your ride has been created.", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                alert.dismiss(animated: true, completion: nil)
                                self.originTextField.text = ""
                                self.destinationTextField.text = ""
                                self.departureTextField.text = ""
                                self.carTextField.text = ""
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Server error. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
        } else {
            
            let alert = UIAlertController(title: "Please fill in all information regarding your ride.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func convertOriginAddress() {
        
        var oAddress:String!
        
        switch self.originTextField.text! {
        case "Macon Campus":
            self.originAddress = "100 University Pkwy, Macon, GA 31206"
            self.originCity = "Macon"
            oAddress = "100 University Pkwy, Macon, GA 31206"
        case "Cochran Campus":
            self.originAddress = "1100 SE 2nd St, Cochran, GA 31014"
            self.originCity = "Cochran"
            oAddress = "1100 SE 2nd St, Cochran, GA 31014"
        case "Eastman Campus":
            self.originAddress = "71 Airport Rd, Eastman, GA 31023"
            self.originCity = "Eastman"
            oAddress = "71 Airport Rd, Eastman, GA 31023"
        case "Warner Robins Campus":
            self.originAddress = "100 University Boulevard, Warner Robins, GA 31093"
            self.originCity = "Warner Robins"
            oAddress = "100 University Boulevard, Warner Robins, GA 31093"
        case "Dublin Campus":
            self.originAddress = "1900 Bellevue Ave, Dublin, GA 31021"
            self.originCity = "Dublin"
            oAddress = "1900 Bellevue Ave, Dublin, GA 31021"
        default:
            break
        }
        
        if self.originTextField.text! != "" {
            coder.geocodeAddressString(oAddress) { (response, error) in
                let latitude = (response?[0].location?.coordinate.latitude)!
                let longitude = (response?[0].location?.coordinate.longitude)!
                self.originCoordinate.latitude = latitude
                self.originCoordinate.longitude = longitude
            }
        }
        
    }
    
    @objc func convertDestAddress() {
        
        var dAddress:String!
        
        switch self.destinationTextField.text! {
        case "Macon Campus":
            self.destinationAddress = "100 University Pkwy, Macon, GA 31206"
            self.destCity = "Macon"
            dAddress = "100 University Pkwy, Macon, GA 31206"
        case "Cochran Campus":
            self.destinationAddress = "1100 SE 2nd St, Cochran, GA 31014"
            self.destCity = "Cochran"
            dAddress = "1100 SE 2nd St, Cochran, GA 31014"
        case "Eastman Campus":
            self.destinationAddress = "71 Airport Rd, Eastman, GA 31023"
            self.destCity = "Eastman"
            dAddress = "71 Airport Rd, Eastman, GA 31023"
        case "Warner Robins Campus":
            self.destinationAddress = "100 University Boulevard, Warner Robins, GA 31093"
            self.destCity = "Warner Robins"
            dAddress = "100 University Boulevard, Warner Robins, GA 31093"
        case "Dublin Campus":
            self.destinationAddress = "1900 Bellevue Ave, Dublin, GA 31021"
            self.destCity = "Dublin"
            dAddress = "1900 Bellevue Ave, Dublin, GA 31021"
        default:
            break
        }
        
        if destinationTextField.text! != "" {
            coder.geocodeAddressString(dAddress) { (response, error) in
                let latitude = (response?[0].location?.coordinate.latitude)!
                let longitude = (response?[0].location?.coordinate.longitude)!
                self.destCoordinate.latitude = latitude
                self.destCoordinate.longitude = longitude
            }
        }
        
    }

}

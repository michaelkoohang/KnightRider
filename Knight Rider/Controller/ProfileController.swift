//
//  ProfileController.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire
import GooglePlaces

class ProfileController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var logoutButton: UIBarButtonItem!
    var segmentedControl: UISegmentedControl!
    var addNewCarButton: UIBarButtonItem!
    var personalView: UIScrollView!
    var carView: UIView!

    var profilePicture: ProfileCircleView!
    var editButton: UIButton!
    var containerView: UIView!
    var seperator1: UIView!
    var seperator2: UIView!
    var seperator3: UIView!
    var seperator4: UIView!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var emailTextField: UITextField!
    var addressTextField: UITextField!
    var phoneTextField: UITextField!
    
    var tableView: UITableView!
    var cars = [Car]()
    var UID = KeychainWrapper.standard.string(forKey: UID_KEY)
    var TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)
    var zipcode: String!
    var picker: UIImagePickerController!
    var currentPhone: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true

        setupNavigationBar()
        setupPersonalView()
        setupCarView()
        setupConstraints()
        
        personalView.isHidden = false
        carView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadUserInfo()
        downloadCarData()
    }
    
    func setupNavigationBar() {
        logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.leftBarButtonItem = logoutButton
        
        addNewCarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCar))
        navigationItem.rightBarButtonItem = addNewCarButton
        
        segmentedControl = UISegmentedControl(items: ["Personal", "Car"])
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        
        addNewCarButton.isEnabled = false
        addNewCarButton.tintColor =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
    }
    
    func setupPersonalView() {
        personalView = UIScrollView()
        personalView.translatesAutoresizingMaskIntoConstraints = false
        personalView.contentSize = view.bounds.size
        
        profilePicture = ProfileCircleView()
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.layer.borderColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1).cgColor
        
        editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Edit Photo", for: .normal)
        editButton.titleLabel?.font = UIFont(name: "Roboto", size: 16)
        editButton.setTitleColor(UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1), for: .normal)
        editButton.addTarget(self, action: #selector(editPhotoPressed(_:)), for: .touchUpInside)
        
        containerView = UIView()
        containerView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        seperator1 = UIView()
        seperator1.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        seperator1.translatesAutoresizingMaskIntoConstraints = false
        
        seperator2 = UIView()
        seperator2.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        seperator2.translatesAutoresizingMaskIntoConstraints = false
        
        seperator3 = UIView()
        seperator3.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        seperator3.translatesAutoresizingMaskIntoConstraints = false
        
        seperator4 = UIView()
        seperator4.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        seperator4.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField = UITextField()
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.clearButtonMode = .whileEditing
        firstNameTextField.isEnabled = false
        firstNameTextField.textColor = UIColor.lightGray
        
        lastNameTextField = UITextField()
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.clearButtonMode = .whileEditing
        lastNameTextField.isEnabled = false
        lastNameTextField.textColor = UIColor.lightGray

        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.isEnabled = false
        emailTextField.textColor = UIColor.lightGray

        addressTextField = UITextField()
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.placeholder = "Address"
        addressTextField.addTarget(self, action: #selector(addressEditing(sender:)), for: .editingDidBegin)
        
        phoneTextField = UITextField()
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.placeholder = "Phone"
        phoneTextField.delegate = self
        
        picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.navigationController?.navigationBar.tintColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1)
        picker.delegate = self
        
        containerView.addSubview(seperator1)
        containerView.addSubview(seperator2)
        containerView.addSubview(seperator3)
        containerView.addSubview(seperator4)
        containerView.addSubview(firstNameTextField)
        containerView.addSubview(lastNameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(addressTextField)
        containerView.addSubview(phoneTextField)
        personalView.addSubview(profilePicture)
        personalView.addSubview(editButton)
        personalView.addSubview(containerView)

        view.addSubview(personalView)
    }
    
    func setupCarView() {
        carView = UIView()
        carView.translatesAutoresizingMaskIntoConstraints = false
        carView.backgroundColor = .green
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        tableView.register(CarCell.self, forCellReuseIdentifier: "carcell")
        tableView.rowHeight = 215
        tableView.separatorStyle = .none
        carView.addSubview(tableView)
        
        view.addSubview(carView)
    }
    
    func setupConstraints() {
        // Personal view constraints.
        personalView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        personalView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        personalView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        personalView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        profilePicture.heightAnchor.constraint(equalToConstant: 110).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 110).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: personalView.centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: personalView.topAnchor, constant: 32).isActive = true
        
        editButton.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 16).isActive = true
        editButton.centerXAnchor.constraint(equalTo: profilePicture.centerXAnchor).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        containerView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 32).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        firstNameTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        firstNameTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        firstNameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5).isActive = true
        
        seperator1.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperator1.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor).isActive = true
        seperator1.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperator1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lastNameTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        lastNameTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: seperator1.bottomAnchor).isActive = true
        lastNameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5).isActive = true
        
        seperator2.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperator2.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor).isActive = true
        seperator2.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: seperator2.bottomAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5).isActive = true
        
        seperator3.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperator3.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        seperator3.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperator3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addressTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12).isActive = true
        addressTextField.topAnchor.constraint(equalTo: seperator3.bottomAnchor).isActive = true
        addressTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5).isActive = true
        
        seperator4.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperator4.topAnchor.constraint(equalTo: addressTextField.bottomAnchor).isActive = true
        seperator4.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperator4.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        phoneTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12).isActive = true
        phoneTextField.topAnchor.constraint(equalTo: seperator4.bottomAnchor).isActive = true
        phoneTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5).isActive = true
        
        // Car view constraints.
        carView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        carView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        carView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        carView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: carView.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: carView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: carView.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: carView.bottomAnchor).isActive = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "carcell", for: indexPath) as? CarCell {
            let car = cars[indexPath.row]
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteCar), for: .touchUpInside)
            cell.configureCell(car: car)
            return cell
        } else {
            return CarCell()
        }

    }
    
    func downloadUserInfo() {
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(USER_URL + "\(UID!)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                let user = User(userDict: dict)
                self.firstNameTextField.text = user.firstName
                self.lastNameTextField.text = user.lastName
                self.emailTextField.text = user.username
                self.addressTextField.text = user.address
                self.phoneTextField.text = user.phone
                self.zipcode = user.zip
                
                if user.profilePicture != "" {
                    let profilePictureURL = URL(string: user.profilePicture)
            
                    Alamofire.request(profilePictureURL!).responseImage { response in
                        if let image = response.result.value {
                            print(response.debugDescription)
                            self.profilePicture.image = image
                        }
                    }
                } else {
                    self.profilePicture.image = UIImage(named: "avatar.png")

                    let alert = UIAlertController(title: "Please update your profile photo.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
        }
        
    }
    
    func downloadCarData() {
        cars.removeAll()
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(CARS_URL + "\(UID!)/cars", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            print(response.debugDescription)
            if let array = response.result.value as? [Dictionary<String, AnyObject>] {
                for obj in array {
                    let car = Car(carsDict: obj)
                    self.cars.append(car)
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    @objc func updateInfo() {

        if addressTextField.text != "" && phoneTextField.text != "" {

            let parameters: Parameters = [
                "firstName" : firstNameTextField.text!.capitalized,
                "lastName" : lastNameTextField.text!.capitalized,
                "username": emailTextField.text!,
                "address": addressTextField.text!,
                "zip": zipcode!,
                "phone": phoneTextField.text!,
            ]

            let tokenHeaders: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Authorization": "Bearer \(TOKEN!)",
                "Cache-Control": "no-cache"
            ]

            Alamofire.request(USER_URL + "\(UID!)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
                
                print(response.debugDescription)

                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if self.addressTextField.text == dict["address"] as? String {
                        if self.zipcode == dict["zip"] as? String {
                            if self.phoneTextField.text == dict["phone"] as? String {
                                let alert = UIAlertController(title: "Info updated successfully.", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)

                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))

                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    } else {
                        let alert = UIAlertController(title: "Update failed. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Please update all fields before you continue.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func encodePhoto(photo: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(photo, 1)
        let strBase64 = imageData?.base64EncodedString()
        return strBase64!
    }
    
    @objc func editPhotoPressed(_ sender: Any) {
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            let parameters: Parameters = [
                "extension": "jpg",
                "profilePicture": encodePhoto(photo: image)
            ]
            
            let tokenHeaders: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Authorization": "Bearer \(TOKEN!)",
                "Cache-Control": "no-cache"
            ]
            
            Alamofire.request(PROFILE_PIC_URL + "\(UID!)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
                
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let _ = dict["profilePicture"] as? String {
                        
                        self.profilePicture.image = image
                        
                    }
                    
                }
                
            }
            
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func deleteCar(sender: UIButton) {
        
        let spinner = ProfileController.displaySpinner(onView: self.tableView)
        let carId = cars[sender.tag].id
        let url = URL(string: ALL_CARS_URL + "\(carId)")
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(url!, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
            print(response.debugDescription)
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let message = dict["message"] as? String {
                    if message == "Successfully deleted!" {
                        ProfileController.removeSpinner(spinner: spinner)
                        
                        let alert = UIAlertController(title: "Car deleted successfully.", message: "", preferredStyle: .actionSheet)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                            self.downloadCarData()
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    if message == "This car cannot be deleted. It is used by trip(s)." {
                        ProfileController.removeSpinner(spinner: spinner)
                        let alert = UIAlertController(title: "You can't delete this car because it is currently being used by one of your rides.", message: "", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    ProfileController.removeSpinner(spinner: spinner)

                    let alert = UIAlertController(title: "Server error. Please try again later.", message: "", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
    }

    @objc func addressEditing(sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateInfo()
    }
    
    @objc func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            addNewCarButton.isEnabled = false
            addNewCarButton.tintColor =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
            personalView.isHidden = false
            carView.isHidden = true
        case 1:
            addNewCarButton.isEnabled = true
            addNewCarButton.tintColor =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            personalView.isHidden = true
            carView.isHidden = false
        default:
            break;
        }
    }
    
    @objc func addNewCar() {
        navigationController?.pushViewController(AddCarController(), animated: true)
    }
    
    @objc func logout() {
        KeychainWrapper.standard.removeObject(forKey: UID_KEY)
        KeychainWrapper.standard.removeObject(forKey: TOKEN_KEY)
        KeychainWrapper.standard.removeObject(forKey: ADDRESS_KEY)
        KeychainWrapper.standard.removeObject(forKey: REFRESH_TOKEN_KEY)
        dismiss(animated: true, completion: nil)
    }

}

extension ProfileController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        addressTextField.text = place.formattedAddress
        for component in place.addressComponents! {
            if component.type == "postal_code" {
                self.zipcode = component.name
            }
        }
        dismiss(animated: true, completion: nil)
        updateInfo()
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



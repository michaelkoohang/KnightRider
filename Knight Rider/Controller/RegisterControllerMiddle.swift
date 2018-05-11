//
//  RegisterControllerMiddle.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import GooglePlaces

class RegisterControllerMiddle: UIViewController {
    
    var firstName: String!
    var lastName: String!
    var address: String!
    var phone: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        setupView()
        addressTextField.addTarget(self, action: #selector(addressEditing(sender:)), for: .editingDidBegin)
        phoneTextField.addTarget(self, action: #selector(phoneEditing(sender:)), for: .editingDidEnd)
        hideKeyboardWhenTappedAround()
    }
    
    let logo: UIImageView = {
        let image = UIImage(named: "kr_logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1)
        button.setTitle("Next", for: .normal)
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
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Address"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = UIKeyboardType.numberPad
        return tf
    }()
    
    let backSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backLink: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupLogo() {
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        logo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        logo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupInputsContainerView() {
        
        inputsContainerView.addSubview(addressTextField)
        inputsContainerView.addSubview(separatorView)
        inputsContainerView.addSubview(phoneTextField)
        
        inputsContainerView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 12).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: logo.leadingAnchor, constant: 0).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 0).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addressTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        addressTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        addressTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 0).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        phoneTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        phoneTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        phoneTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupNextButton() {
        nextButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 0).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: 0).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    func setupBack() {
        backSeparatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backSeparatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        backSeparatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        backSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        backLink.topAnchor.constraint(equalTo: backSeparatorView.bottomAnchor, constant: 8).isActive = true
        backLink.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backLink.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    func setupView() {
        view.addSubview(logo)
        view.addSubview(inputsContainerView)
        view.addSubview(nextButton)
        view.addSubview(backSeparatorView)
        view.addSubview(backLink)
        setupLogo()
        setupInputsContainerView()
        setupNextButton()
        setupBack()
    }
    
    @objc func addressEditing(sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @objc func phoneEditing(sender: UITextField) {
        phone = phoneTextField.text!
    }
    
    @objc func goNext() {
        let vc = RegisterControllerEnd()
        vc.firstName = firstName
        vc.lastName = lastName
        vc.address = address
        vc.phone = phone

        if vc.address != nil && vc.phone != nil {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Please fill in all information required.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension RegisterControllerMiddle: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        addressTextField.text = place.formattedAddress
        address = place.formattedAddress
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

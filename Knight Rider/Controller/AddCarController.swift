//
//  AddCarController.swift
//  Knight Rider
//
//  Created by Michael on 5/7/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class AddCarController: UIViewController {

    var UID = KeychainWrapper.standard.string(forKey: UID_KEY)
    var TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Car"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        hideKeyboardWhenTappedAround()
    }
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addCar), for: .touchUpInside)
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
    
    let makeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Make"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let modelTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Model"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let availableSeatsTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Available Seats"
        tf.keyboardType = .numberPad
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setupInputsContainerView() {
        
        inputsContainerView.addSubview(makeTextField)
        inputsContainerView.addSubview(modelTextField)
        inputsContainerView.addSubview(availableSeatsTextField)
        inputsContainerView.addSubview(separatorView1)
        inputsContainerView.addSubview(separatorView2)
        
        inputsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        makeTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        makeTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        makeTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        makeTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView1.topAnchor.constraint(equalTo: makeTextField.bottomAnchor, constant: 0).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        modelTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        modelTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        modelTextField.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 0).isActive = true
        modelTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView2.topAnchor.constraint(equalTo: modelTextField.bottomAnchor, constant: 0).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        availableSeatsTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        availableSeatsTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        availableSeatsTextField.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 0).isActive = true
        availableSeatsTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true

    }
    
    func setupCreateButton() {
        addButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        addButton.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: 0).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.addSubview(inputsContainerView)
        view.addSubview(addButton)
        setupInputsContainerView()
        setupCreateButton()
    }

    @objc func addCar() {
        
        if makeTextField.text != "" && modelTextField.text != "" && availableSeatsTextField.text != "" {
            let parameters: Parameters = [
                "maker" : makeTextField.text!,
                "type" : modelTextField.text!,
                "capacity" : availableSeatsTextField.text!
            ]
            
            let tokenHeaders: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Authorization": "Bearer \(TOKEN!)",
                "Cache-Control": "no-cache"
            ]
            
            Alamofire.request(CARS_URL + "\(UID!)/cars", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { response in
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if let make = dict["maker"] as? String {
                        if make == self.makeTextField.text {
                            let alert = UIAlertController(title: "Car added successfully.", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                self.makeTextField.text = ""
                                self.modelTextField.text = ""
                                self.availableSeatsTextField.text = ""
                                self.navigationController?.popViewController(animated: true)
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Server error. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Please fill in all required information.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}

//
//  RegisterControllerStart.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit

class RegisterControllerStart: UIViewController, UITextFieldDelegate {
    
    var firstName: String!
    var lastName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        setupView()
        firstNameTextField.addTarget(self, action: #selector(firstNameEditing(sender:)), for: .editingDidEnd)
        lastNameTextField.addTarget(self, action: #selector(lastNameEditing(sender:)), for: .editingDidEnd)
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
    
    let firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First Name"
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
    
    let lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Last Name"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
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
        
        inputsContainerView.addSubview(firstNameTextField)
        inputsContainerView.addSubview(separatorView)
        inputsContainerView.addSubview(lastNameTextField)
        
        inputsContainerView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 12).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: logo.leadingAnchor, constant: 0).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 0).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        firstNameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        firstNameTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        firstNameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 0).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lastNameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        lastNameTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        lastNameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
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
        backSeparatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
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
    
    @objc func firstNameEditing(sender: UITextField) {
        firstName = firstNameTextField.text!
    }
    
    @objc func lastNameEditing(sender: UITextField) {
        lastName = lastNameTextField.text!
    }
    
    @objc func goNext() {
        let vc = RegisterControllerMiddle()
        vc.firstName = firstName
        vc.lastName = lastName
        if vc.firstName != nil && vc.lastName != nil {
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

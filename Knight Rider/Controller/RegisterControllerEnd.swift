//
//  RegisterControllerEnd.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire

class RegisterControllerEnd: UIViewController {
    
    var firstName: String!
    var lastName: String!
    var address: String!
    var phone: String!
    var email: String!
    var password: String!
    var confirmPasssword: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        setupView()
        emailTextField.addTarget(self, action: #selector(emailEditing(sender:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(passwordEditing(sender:)), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordEditing(sender:)), for: .editingDidEnd)
        hideKeyboardWhenTappedAround()
    }
    
    let logo: UIImageView = {
        let image = UIImage(named: "kr_logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1)
        button.setTitle("Register", for: .normal)
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
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "MGA Email"
        tf.keyboardType = UIKeyboardType.emailAddress
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
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
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
    
    let confirmPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Confirm Password"
        tf.isSecureTextEntry = true
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
        
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(separatorView1)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(confirmPasswordTextField)
        inputsContainerView.addSubview(separatorView2)
        
        inputsContainerView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 12).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: logo.leadingAnchor, constant: 0).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 0).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView1.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView2.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        confirmPasswordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        confirmPasswordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 0).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupRegisterButton() {
        registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 0).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: 0).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
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
        view.addSubview(registerButton)
        view.addSubview(backSeparatorView)
        view.addSubview(backLink)
        setupLogo()
        setupInputsContainerView()
        setupRegisterButton()
        setupBack()
    }
    
    @objc func emailEditing(sender: UITextField) {
        email = emailTextField.text!
    }
    
    @objc func passwordEditing(sender: UITextField) {
        password = passwordTextField.text!
    }
    
    @objc func confirmPasswordEditing(sender: UITextField) {
        confirmPasssword = confirmPasswordTextField.text!
    }
    
    @objc func register() {
        
        if password == confirmPasssword {
            
            let registerParameters: Parameters = [
                "firstName" : firstName!.capitalized,
                "lastName" : lastName!.capitalized,
                "email" : email!,
                "address": address!,
                "phone": phone!,
                "password" : password!,
                "matchingPassword": confirmPasssword!
            ]
            
            Alamofire.request(REGISTER_URL, method: .post, parameters: registerParameters, encoding: JSONEncoding.default, headers: regularHeaders).responseJSON { response in
                
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let message = dict["message"] as? String {
                        
                        if message == "Success. Please check your email." {
                            
                            let alert = UIAlertController(title: "Success!", message: "Please check your email to confirm your account. Once you've done that, you can log in and start using the app.", preferredStyle: UIAlertControllerStyle.actionSheet)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                alert.dismiss(animated: true, completion: nil)
                                self.navigationController?.popToRootViewController(animated: true)
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        } else {
                            
                            let alert = UIAlertController(title: "Registration error. Please review your information and try again.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Sever error. Please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
        } else {
            
            let alert = UIAlertController(title: "Passwords do not match. Please try again.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
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

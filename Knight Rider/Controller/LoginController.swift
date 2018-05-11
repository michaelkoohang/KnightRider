//
//  LoginController.swift
//  Knight Rider
//
//  Created by Michael on 2/20/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        setupView()
        hideKeyboardWhenTappedAround()
        if let _ = KeychainWrapper.standard.string(forKey: UID_KEY) {
            self.present(TabBarController(), animated: true, completion: nil)
        }
    }
        
    let logo: UIImageView = {
        let image = UIImage(named: "kr_logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    let separatorView: UIView = {
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 99/255, green: 55/255, blue: 147/255, alpha: 1)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let signUpLink: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
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
        inputsContainerView.addSubview(separatorView)
        inputsContainerView.addSubview(passwordTextField)

        inputsContainerView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 12).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: logo.leadingAnchor, constant: 0).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 0).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupLoginButton() {
        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 0).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: 0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    func setupSignUp() {
        signUpSeparatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        signUpSeparatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        signUpSeparatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        signUpSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        signUpLink.topAnchor.constraint(equalTo: signUpSeparatorView.bottomAnchor, constant: 8).isActive = true
        signUpLink.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpLink.addTarget(self, action: #selector(startRegistration), for: .touchUpInside)
    }
    
    func setupView() {
        view.addSubview(logo)
        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)
        view.addSubview(signUpSeparatorView)
        view.addSubview(signUpLink)
        setupLogo()
        setupInputsContainerView()
        setupLoginButton()
        setupSignUp()
    }
    
    @objc func startRegistration() {
        self.navigationController?.pushViewController(RegisterControllerStart(), animated: true)
    }
    
    @objc func login() {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        if email != "" && password != "" {
            
            let loginParameters: Parameters = [
                "username": "\(email)",
                "password": "\(password)"
            ]
            
            Alamofire.request(LOGIN_URL, method: .post, parameters: loginParameters, encoding: JSONEncoding.default, headers: regularHeaders).responseJSON { response in
                
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let userId = dict["user_id"] as? String {
                        
                        KeychainWrapper.standard.set(userId, forKey: UID_KEY)
                        
                        if let token = dict["token"] as? String {
                            KeychainWrapper.standard.set(token, forKey: TOKEN_KEY)
                        }
                        
                        if let refreshToken = dict["refresh_token"] as? String {
                            KeychainWrapper.standard.set(refreshToken, forKey: REFRESH_TOKEN_KEY)
                        }
                        
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                        self.present(TabBarController(), animated: true, completion: nil)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Incorrect credentials or email not validated. Please try again.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            alert.dismiss(animated: true, completion: nil)
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
            
//            let id = KeychainWrapper.standard.string(forKey: UID_KEY)
//            let deviceToken = KeychainWrapper.standard.string(forKey: DEVICE_KEY)
//            let TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)
//            
//            let tokenHeaders: HTTPHeaders = [
//                "Content-Type": "application/json",
//                "X-Authorization": "Bearer \(TOKEN!)",
//                "Cache-Control": "no-cache"
//            ]
            
//            let deviceRegistrationParameters: Parameters = [
//                "userId": "\(id!)",
//                "deviceType": "iOS",
//                "deviceToken": "\(deviceToken!)"
//            ]
            
//            Alamofire.request(DEVICE_REGISTRATION_URL, method: .post, parameters: deviceRegistrationParameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { (response) in
//
//                print(response.debugDescription)
//                print("\nSUCCESS\n")
//
//            }
        } else {
            
            let alert = UIAlertController(title: "Please enter username and password.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}













//
//  CarCell.swift
//  Knight Rider
//
//  Created by Michael on 5/7/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class CarCell: UITableViewCell {
    
    var card: UIView!
    var makeLabel: UILabel!
    var make: UILabel!
    var modelLabel: UILabel!
    var model: UILabel!
    var seatsAvailableLabel: UILabel!
    var seatsAvailable: UILabel!
    var separator1: UIView!
    var separator2: UIView!
    var separator3: UIView!
    var deleteButton: UIButton!
    
    let UID = KeychainWrapper.standard.string(forKey: UID_KEY)
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        setupCell()
    }
    
    func setupCell() {
        
        // Card base.
        card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        
        // Destination and time info.
        makeLabel = UILabel()
        makeLabel.translatesAutoresizingMaskIntoConstraints = false
        makeLabel.font = UIFont(name: "Roboto-Regular", size: 10)
        makeLabel.text = "Make"
        makeLabel.textColor = UIColor.gray

        make = UILabel()
        make.translatesAutoresizingMaskIntoConstraints = false
        make.font = UIFont(name: "Roboto-Bold", size: 14)
        
        modelLabel = UILabel()
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        modelLabel.font = UIFont(name: "Roboto-Regular", size: 10)
        modelLabel.text = "Model"
        modelLabel.textColor = UIColor.gray

        model = UILabel()
        model.translatesAutoresizingMaskIntoConstraints = false
        model.font = UIFont(name: "Roboto-Bold", size: 14)
        
        seatsAvailableLabel = UILabel()
        seatsAvailableLabel.translatesAutoresizingMaskIntoConstraints = false
        seatsAvailableLabel.font = UIFont(name: "Roboto-Regular", size: 10)
        seatsAvailableLabel.text = "Seats Available"
        seatsAvailableLabel.textColor = UIColor.gray
        
        seatsAvailable = UILabel()
        seatsAvailable.translatesAutoresizingMaskIntoConstraints = false
        seatsAvailable.font = UIFont(name: "Roboto-Bold", size: 14)

        separator1 = UIView()
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.backgroundColor = UIColor.lightGray
        
        separator2 = UIView()
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.backgroundColor = .lightGray
        
        separator3 = UIView()
        separator3.translatesAutoresizingMaskIntoConstraints = false
        separator3.backgroundColor = .lightGray
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        
        card.addSubview(makeLabel)
        card.addSubview(make)
        card.addSubview(modelLabel)
        card.addSubview(model)
        card.addSubview(seatsAvailableLabel)
        card.addSubview(seatsAvailable)
        card.addSubview(separator1)
        card.addSubview(separator2)
        card.addSubview(separator3)
        card.addSubview(deleteButton)
        contentView.addSubview(card)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        card.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        card.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        card.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        card.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        makeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        makeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        makeLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 8).isActive = true
        makeLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        make.heightAnchor.constraint(equalToConstant: 16).isActive = true
        make.widthAnchor.constraint(equalToConstant: 100).isActive = true
        make.topAnchor.constraint(equalTo: makeLabel.bottomAnchor, constant: 6).isActive = true
        make.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        separator1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator1.topAnchor.constraint(equalTo: make.bottomAnchor, constant: 8).isActive = true
        separator1.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        separator1.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        modelLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        modelLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        modelLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 8).isActive = true
        modelLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        model.heightAnchor.constraint(equalToConstant: 16).isActive = true
        model.widthAnchor.constraint(equalToConstant: 100).isActive = true
        model.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 6).isActive = true
        model.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        separator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator2.topAnchor.constraint(equalTo: model.bottomAnchor, constant: 8).isActive = true
        separator2.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        separator2.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        seatsAvailableLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        seatsAvailableLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        seatsAvailableLabel.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 8).isActive = true
        seatsAvailableLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        seatsAvailable.heightAnchor.constraint(equalToConstant: 16).isActive = true
        seatsAvailable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        seatsAvailable.topAnchor.constraint(equalTo: seatsAvailableLabel.bottomAnchor, constant: 6).isActive = true
        seatsAvailable.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        separator3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator3.topAnchor.constraint(equalTo: seatsAvailable.bottomAnchor, constant: 8).isActive = true
        separator3.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        separator3.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true

        deleteButton.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -12).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -4).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func configureCell(car: Car) {
        make.text = car.maker
        model.text = car.type
        seatsAvailable.text = "\(car.capacity)"
    }

}

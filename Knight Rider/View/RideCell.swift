//
//  RideCell.swift
//  Knight Rider
//
//  Created by Michael on 3/27/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftKeychainWrapper

class RideCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var card: UIView!
    var travelLabel: UILabel!
    var dateLabel: UILabel!
    var reimbursement: UILabel!
    var reimbursementLabel: UILabel!
    var separator1: UIView!
    
    var meetingLocationLabel: UILabel!
    var meetingLocation: UILabel!
    var dropoffLocationLabel: UILabel!
    var dropoffLocation: UILabel!
    var separator2: UIView!
    
    var layout: UICollectionViewFlowLayout!
    var passengerView: UICollectionView!
    var separator3: UIView!
    
    var messagesButton: UIButton!
    var leaveButton: UIButton!
    var joinButton: UIButton!
    var deleteButton: UIButton!
    
    var driver: User!
    var passengers = [User]()
    
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
        travelLabel = UILabel()
        travelLabel.translatesAutoresizingMaskIntoConstraints = false
        travelLabel.font = UIFont(name: "Roboto-Bold", size: 14)

        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Roboto-Regular", size: 10)
        dateLabel.textColor = UIColor.gray
        
        separator1 = UIView()
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.backgroundColor = UIColor.lightGray
        
        reimbursement = UILabel()
        reimbursement.translatesAutoresizingMaskIntoConstraints = false
        reimbursement.font = UIFont(name: "Roboto-Bold", size: 16)
        reimbursement.textAlignment = .right
        
        reimbursementLabel = UILabel()
        reimbursementLabel.translatesAutoresizingMaskIntoConstraints = false
        reimbursementLabel.font = UIFont(name: "Roboto-Italic", size: 10)
        reimbursementLabel.textColor = UIColor.gray
        reimbursementLabel.textAlignment = .right
        reimbursementLabel.text = "Reimbursed"
        
        meetingLocationLabel = UILabel()
        meetingLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        meetingLocationLabel.font = UIFont(name: "Roboto", size: 8)
        meetingLocationLabel.textColor = UIColor.gray
        meetingLocationLabel.text = "Meeting Location"
        
        meetingLocation = UILabel()
        meetingLocation.translatesAutoresizingMaskIntoConstraints = false
        meetingLocation.font = UIFont(name: "Roboto-Bold", size: 10)
        
        dropoffLocationLabel = UILabel()
        dropoffLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        dropoffLocationLabel.font = UIFont(name: "Roboto", size: 8)
        dropoffLocationLabel.textColor = UIColor.gray
        dropoffLocationLabel.text = "Dropoff Location"

        dropoffLocation = UILabel()
        dropoffLocation.translatesAutoresizingMaskIntoConstraints = false
        dropoffLocation.font = UIFont(name: "Roboto-Bold", size: 10)
        
        separator2 = UIView()
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.backgroundColor = .lightGray
        
        layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 7.5, left: 12.5, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 40, height: 40)
        
        passengerView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        passengerView.translatesAutoresizingMaskIntoConstraints = false
        passengerView.dataSource = self
        passengerView.delegate = self
        passengerView.register(PassengerCell.self, forCellWithReuseIdentifier: "passengerCell")
        passengerView.backgroundColor = .white
        
        separator3 = UIView()
        separator3.translatesAutoresizingMaskIntoConstraints = false
        separator3.backgroundColor = .lightGray
        
        messagesButton = UIButton()
        messagesButton.translatesAutoresizingMaskIntoConstraints = false
        messagesButton.setTitle("View Messages", for: .normal)
        messagesButton.setTitleColor(UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1), for: .normal)
        messagesButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        
        leaveButton = UIButton()
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        leaveButton.setTitle("Leave", for: .normal)
        leaveButton.setTitleColor(UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1), for: .normal)
        leaveButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        
        joinButton = UIButton()
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.setTitle("Join", for: .normal)
        joinButton.setTitleColor(UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1), for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1), for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)

        card.addSubview(travelLabel)
        card.addSubview(dateLabel)
        card.addSubview(separator1)
        card.addSubview(reimbursement)
        card.addSubview(reimbursementLabel)
        card.addSubview(meetingLocation)
        card.addSubview(meetingLocationLabel)
        card.addSubview(dropoffLocation)
        card.addSubview(dropoffLocationLabel)
        card.addSubview(separator2)
        card.addSubview(passengerView)
        card.addSubview(separator3)
        card.addSubview(leaveButton)
        card.addSubview(deleteButton)
        card.addSubview(joinButton)
        card.addSubview(messagesButton)
        contentView.addSubview(card)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        card.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        card.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        card.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        card.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        travelLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        travelLabel.widthAnchor.constraint(equalToConstant: 175).isActive = true
        travelLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 12).isActive = true
        travelLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        dateLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 125).isActive = true
        dateLabel.topAnchor.constraint(equalTo: travelLabel.bottomAnchor, constant: 4).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: travelLabel.leadingAnchor).isActive = true
        
        reimbursement.heightAnchor.constraint(equalToConstant: 16).isActive = true
        reimbursement.widthAnchor.constraint(equalToConstant: 60).isActive = true
        reimbursement.topAnchor.constraint(equalTo: card.topAnchor, constant: 12).isActive = true
        reimbursement.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -12).isActive = true
        
        reimbursementLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        reimbursementLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        reimbursementLabel.topAnchor.constraint(equalTo: reimbursement.bottomAnchor, constant: 4).isActive = true
        reimbursementLabel.trailingAnchor.constraint(equalTo: reimbursement.trailingAnchor).isActive = true
        
        separator1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator1.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        separator1.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        separator1.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        meetingLocationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        meetingLocationLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        meetingLocationLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 8).isActive = true
        meetingLocationLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        
        meetingLocation.heightAnchor.constraint(equalToConstant: 16).isActive = true
        meetingLocation.widthAnchor.constraint(equalToConstant: 125).isActive = true
        meetingLocation.topAnchor.constraint(equalTo: meetingLocationLabel.bottomAnchor, constant: 2).isActive = true
        meetingLocation.leadingAnchor.constraint(equalTo: meetingLocationLabel.leadingAnchor).isActive = true
        
        dropoffLocationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dropoffLocationLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        dropoffLocationLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 8).isActive = true
        dropoffLocationLabel.leftAnchor.constraint(equalTo: card.centerXAnchor).isActive = true

        dropoffLocation.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dropoffLocation.widthAnchor.constraint(equalToConstant: 60).isActive = true
        dropoffLocation.topAnchor.constraint(equalTo: meetingLocationLabel.bottomAnchor, constant: 2).isActive = true
        dropoffLocation.leftAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
        
        separator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator2.topAnchor.constraint(equalTo: meetingLocation.bottomAnchor, constant: 8).isActive = true
        separator2.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        separator2.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        passengerView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passengerView.topAnchor.constraint(equalTo: separator2.bottomAnchor).isActive = true
        passengerView.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        passengerView.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        separator3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator3.topAnchor.constraint(equalTo: passengerView.bottomAnchor).isActive = true
        separator3.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        separator3.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        deleteButton.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -4).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        leaveButton.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        leaveButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -4).isActive = true
        leaveButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leaveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        joinButton.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 12).isActive = true
        joinButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -4).isActive = true
        joinButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        joinButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        messagesButton.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -12).isActive = true
        messagesButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -4).isActive = true
        messagesButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        messagesButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passengers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = passengerView.dequeueReusableCell(withReuseIdentifier: "passengerCell", for: indexPath) as? PassengerCell {
            if indexPath.row == 0 {
                cell.profileFrame.layer.borderColor = UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1).cgColor
            }
            cell.configureCell(passenger: passengers[indexPath.row])
            return cell
        } else {
            return PassengerCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func configureCell(ride: Ride) {
        travelLabel.text = "\(ride.originCity) to \(ride.destCity)"
        dateLabel.text = ride.departureTime
        reimbursement.text = "$24"
        meetingLocation.text = ride.meetingLocation
        dropoffLocation.text = ride.destName
        passengerView.reloadData()

        if (ride.driverId == Int(UID!)) {
            joinButton.isEnabled = false
            joinButton.isHidden = true
            leaveButton.isEnabled = false
            leaveButton.isHidden = true
            deleteButton.isEnabled = true
            deleteButton.isHidden = false
        } else if (passengers.contains(where: { (user) -> Bool in
            user.id == Int(UID!)
        })) {
            joinButton.isEnabled = false
            joinButton.isHidden = true
            leaveButton.isEnabled = true
            leaveButton.isHidden = false
            deleteButton.isEnabled = false
            deleteButton.isHidden = true
        } else {
            joinButton.isEnabled = true
            joinButton.isHidden = false
            leaveButton.isEnabled = false
            leaveButton.isHidden = true
            deleteButton.isEnabled = false
            deleteButton.isHidden = true
            messagesButton.isEnabled = false
            messagesButton.isHidden = true
        }
        
    }
    
}



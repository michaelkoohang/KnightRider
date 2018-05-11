//
//  PassengerCell.swift
//  Knight Rider
//
//  Created by Michael on 5/5/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PassengerCell: UICollectionViewCell {
    
    var profileFrame: ProfileCircleView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        profileFrame = ProfileCircleView()
        profileFrame.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileFrame)
    }
    
    func setupConstraints() {
        profileFrame.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        profileFrame.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileFrame.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        profileFrame.widthAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
    
    func configureCell(passenger: User) {
        
        if passenger.profilePicture != "" {
            let profilePictureURL = URL(string: passenger.profilePicture)
            
            Alamofire.request(profilePictureURL!).responseImage { response in
                if let image = response.result.value {
                    print(response.debugDescription)
                    self.profileFrame.image = image
                }
            }
        } else {
            self.profileFrame.image = UIImage(named: "avatar.png")
        }
        
    }
    
}

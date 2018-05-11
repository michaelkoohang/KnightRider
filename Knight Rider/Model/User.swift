//
//  User.swift
//  Knight Rider
//
//  Created by Michael K. on 8/5/17.
//  Copyright © 2017 MGA. All rights reserved.
//

import Foundation

class User {
    
    private var _id: Int!
    private var _driverId: Int!
    private var _username: String!
    private var _firstName: String!
    private var _lastName: String!
    private var _address: String!
    private var _zip: String!
    private var _phone: String!
    private var _profilePicture: String!
    
    var id: Int {
        if _id == nil {
            _id = 0
        }
        return _id
    }
    
    var driverId: Int {
        if _driverId == nil {
            _driverId = 0
        }
        return _driverId
    }
    
    var username: String {
        if _username == nil {
            _username = ""
        }
        return _username
    }
    
    var firstName: String {
        if _firstName == nil {
            _firstName = ""
        }
        return _firstName
    }
    
    var lastName: String {
        if _lastName == nil {
            _lastName = ""
        }
        return _lastName
    }
    
    var address: String {
        if _address == nil {
            _address = ""
        }
        return _address
    }
    
    var zip: String {
        if _zip == nil {
            _zip = ""
        }
        return _zip
    }
    
    var phone: String {
        if _phone == nil {
            _phone = ""
        }
        return _phone
    }
    
    var profilePicture: String {
        if _profilePicture == nil {
            _profilePicture = ""
        }
        return _profilePicture
    }
    
    init(userDict: Dictionary<String, AnyObject>) {
        
        if let id = userDict["id"] as? Int {
            self._id = id
        }
        
        if let driverId = userDict["driverId"] as? Int {
            self._driverId = driverId
        }
        
        if let username = userDict["username"] as? String {
            self._username = username
        }
        
        if let firstName = userDict["firstName"] as? String {
            self._firstName = firstName
        }
        
        if let lastName = userDict["lastName"] as? String {
            self._lastName = lastName
        }
        
        if let address = userDict["address"] as? String {
            self._address = address
        }
        
        if let zip = userDict["zip"] as? String {
            self._zip = zip
        }
        
        if let phone = userDict["phone"] as? String {
            self._phone = phone
        }
        
        if let profilePicture = userDict["profilePicture"] as? String {
            self._profilePicture = profilePicture
        }
        
    }
    
}

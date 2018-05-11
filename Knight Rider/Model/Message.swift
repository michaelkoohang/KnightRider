//
//  Messages.swift
//  Knight Rider
//
//  Created by Michael K. on 8/2/17.
//  Copyright © 2017 MGA. All rights reserved.
//

import Foundation

class Message {
    
    private var _id: Int!
    private var _logDate: Date!
    private var _comment: String!
    private var _tripId: Int!
    private var _userId: Int!
    private var _firstName: String!
    private var _lastName: String!
    private var _profilePicture: String!
    
    var id: Int {
        if _id == nil {
            _id = 0
        }
        return _id
    }
    
    var logDate: Date {
        if _logDate == nil {
            _logDate = Date()
        }
        return _logDate
    }
    
    var comment: String {
        if _comment == nil {
            _comment = ""
        }
        return _comment
    }
    
    var tripId: Int {
        if _tripId == nil {
            _tripId = 0
        }
        return _tripId
    }
    
    var userId: Int {
        if _userId == nil {
            _userId = 0
        }
        return _userId
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
    
    var profilePicture: String {
        if _profilePicture == nil {
            _profilePicture = ""
        }
        return _profilePicture
    }
    
    init(messageDict: Dictionary<String, AnyObject>) {
        
        if let id = messageDict["id"] as? Int {
            self._id = id
        }
        
        if var logDate = messageDict["logDate"] as? Double {
            logDate = logDate / 1000
            let date = Date(timeIntervalSince1970: logDate)

            self._logDate = date
        }
        
        if let comment = messageDict["comment"] as? String {
            self._comment = comment
        }
        
        if let tripId = messageDict["tripId"] as? Int {
            self._tripId = tripId
        }
        
        if let userId = messageDict["userId"] as? Int {
            self._userId = userId
        }
        
        if let firstName = messageDict["firstName"] as? String {
            self._firstName = firstName
        }
        
        if let lastName = messageDict["lastName"] as? String {
            self._lastName = lastName
        }
        
        if let profilePicture = messageDict["profilePicture"] as? String {
            self._profilePicture = profilePicture
        }
        
    }
    
}


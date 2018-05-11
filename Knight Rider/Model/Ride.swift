//
//  Ride.swift
//  Knight Rider
//
//  Created by Michael K. on 7/25/17.
//  Copyright © 2017 MGA. All rights reserved.
//

import Foundation

class Ride {
    
    private var _id: Int!
    private var _driverId: Int!
    private var _originAddress: String!
    private var _originCity: String!
    private var _originLatitude: Double!
    private var _originLongitude: Double!
    private var _destAddress: String!
    private var _destCity: String!
    private var _destLatitude: Double!
    private var _destLongitude: Double!
    private var _departureTime: String!
    private var _meetingLocation: String!
    private var _destName: String!
    private var _meetingLatitude: Double!
    private var _meetingLongitude: Double!
    private var _remainingSeats: Int!
    private var _car: Car!
    private var _driver: User!
    var passengers = [User]()
    var messages = [Message]()
    
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
    
    var originAddress: String {
        if _originAddress == nil {
            _originAddress = ""
        }
        return _originAddress
    }
    
    var originCity: String {
        if _originCity == nil {
            _originCity = ""
        }
        return _originCity
    }
    
    var originLatitude: Double {
        if _originLatitude == nil {
            _originLatitude = 0.0
        }
        return _originLatitude
    }
    
    var originLongitude: Double {
        if _originLongitude == nil {
            _originLongitude = 0.0
        }
        return _originLongitude
    }
    
    var destAddress: String {
        if _destAddress == nil {
            _destAddress = ""
        }
        return _destAddress
    }
    
    var destCity: String {
        if _destCity == nil {
            _destCity = ""
        }
        return _destCity
    }
    
    var destLatitude: Double {
        if _destLatitude == nil {
            _destLatitude = 0.0
        }
        return _destLatitude
    }
    
    var destLongitude: Double {
        if _destLongitude == nil {
            _destLongitude = 0.0
        }
        return _destLongitude
    }
    
    var departureTime: String {
        if _departureTime == nil {
            _departureTime = ""
        }
        return _departureTime
    }
    
    var meetingLocation: String {
        if _meetingLocation == nil {
            _meetingLocation = ""
        }
        return _meetingLocation
    }
    
    var destName: String {
        if _destName == nil {
            _destName = ""
        }
        return _destName
    }
    
    var meetingLatitude: Double {
        if _meetingLatitude == nil {
            _meetingLatitude = 0.0
        }
        return _meetingLatitude
    }
    
    var meetingLongitude: Double {
        if _meetingLongitude == nil {
            _meetingLongitude = 0.0
        }
        return _meetingLongitude
    }
    
    var remainingSeats: Int {
        if _remainingSeats == nil {
            _remainingSeats = 0
        }
        return _remainingSeats
    }
    
    var car: Car {
        return _car
    }
    
    var driver: User {
        return _driver
    }
    
    init(ridesDict: Dictionary<String, AnyObject>) {
        
        if let id = ridesDict["id"] as? Int {
            self._id = id
        }
        
        if let driverId = ridesDict["driverId"] as? Int {
            self._driverId = driverId
        }
        
        if let originAddress = ridesDict["originAddress"] as? String {
            self._originAddress = originAddress
        }
        
        if let originCity = ridesDict["originCity"] as? String {
            self._originCity = originCity
        }
        
        if let originLatitude = ridesDict["originLatitude"] as? Double {
            self._originLatitude = originLatitude
        }
        
        if let originLongitude = ridesDict["originLongitude"] as? Double {
            self._originLongitude = originLongitude
        }
        
        if let destAddress = ridesDict["destAddress"] as? String {
            self._destAddress = destAddress
        }
        
        if let destCity = ridesDict["destCity"] as? String {
            self._destCity = destCity
        }
        
        if let destLatitude = ridesDict["destLatitude"] as? Double {
            self._destLatitude = destLatitude
        }
        
        if let destLongitude = ridesDict["destLongitude"] as? Double {
            self._destLongitude = destLongitude
        }
        
        if let destName = ridesDict["destName"] as? String {
            self._destName = destName
        }
        
        if var departureTime = ridesDict["departureTime"] as? Double {
            departureTime = departureTime / 1000
            let date = NSDate(timeIntervalSince1970: departureTime)
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY " + "-" + " h:mm a"
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            
            self._departureTime = dateString
        }
        
        if let meetingLocation = ridesDict["meetingLocation"] as? String {
            self._meetingLocation = meetingLocation
        }
        
        if let meetingLatitude = ridesDict["meetingLatitude"] as? Double {
            self._meetingLatitude = meetingLatitude
        }
        
        if let meetingLongitude = ridesDict["meetingLongitude"] as? Double {
            self._meetingLongitude = meetingLongitude
        }
        
        if let remainingSeats = ridesDict["remainingSeats"] as? Int {
            self._remainingSeats = remainingSeats
        }
        
        if let car = ridesDict["car"] as? Dictionary<String, AnyObject> {
            let car = Car(carsDict: car)
            self._car = car
        }
        
        if let car = ridesDict["car"] as? Dictionary<String, AnyObject> {
            let car = Car(carsDict: car)
            self._car = car
        }
        
        if let driver = ridesDict["driver"] as? Dictionary<String, AnyObject> {
            let driver = User(userDict: driver)
            self._driver = driver
        }
        
        if let passengersArray = ridesDict["passengers"] as? [Dictionary<String, AnyObject>] {
            for obj in passengersArray {
                let passenger = User(userDict: obj)
                self.passengers.append(passenger)
            }
        }
        
        if let messagesArray = ridesDict["messages"] as? [Dictionary<String, AnyObject>] {
            for obj in messagesArray {
                let message = Message(messageDict: obj)
                self.messages.append(message)
            }
        }
        
    }

}





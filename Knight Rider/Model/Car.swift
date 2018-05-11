//
//  Car.swift
//  Knight Rider
//
//  Created by Michael K. on 7/28/17.
//  Copyright © 2017 MGA. All rights reserved.
//

import Foundation

class Car {
    
    private var _id: Int!
    private var _maker: String!
    private var _type: String!
    private var _capacity: Int!
    
    var id: Int {
        if _id == nil {
            _id = 0
        }
        return _id
    }
    
    var maker: String {
        if _maker == nil {
            _maker = ""
        }
        return _maker
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var capacity: Int {
        if _capacity == nil {
            _capacity = 0
        }
        return _capacity
    }
    
    init(carsDict: Dictionary<String, AnyObject>) {
        
        if let id = carsDict["id"] as? Int {
            self._id = id
        }
        
        if let maker = carsDict["maker"] as? String {
            self._maker = maker
        }
        
        if let type = carsDict["type"] as? String {
            self._type = type
        }
        
        if let capacity = carsDict["capacity"] as? Int {
            self._capacity = capacity
        }
        
    }
    
}

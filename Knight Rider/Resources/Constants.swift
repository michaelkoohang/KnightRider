//
//  Constants.swift
//  Knight Rider
//
//  Created by Michael K. on 6/30/17.
//  Copyright © 2017 MGA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

let UID_KEY = "uid"
let TOKEN_KEY = "token"
let REFRESH_TOKEN_KEY = "refreshToken"
let ADDRESS_KEY = "address"
let DEVICE_KEY = "deviceToken"

let LOGIN_URL = "http://knightrider.mgaitec.net:8080/ridesharing/auth/login"
let REGISTER_URL = "http://knightrider.mgaitec.net:8080/ridesharing/auth/register"
let USER_URL = "http://knightrider.mgaitec.net:8080/ridesharing/users/"
let PROFILE_PIC_URL = "http://knightrider.mgaitec.net:8080/ridesharing/users/profilepicture/"
let RIDES_URL = "http://knightrider.mgaitec.net:8080/ridesharing/users/"
let CARS_URL = "http://knightrider.mgaitec.net:8080/ridesharing/users/"
let ALL_CARS_URL = "http://knightrider.mgaitec.net:8080/ridesharing/cars/"
let ALL_TRIPS = "http://knightrider.mgaitec.net:8080/ridesharing/trips"
let TRIPS_SEARCH_URL = "http://knightrider.mgaitec.net:8080/ridesharing/trips/search"
let DELETE_TRIP_URL = "http://knightrider.mgaitec.net:8080/ridesharing/trips/"
let PASSENGERS_URL = "http://knightrider.mgaitec.net:8080/ridesharing/passengers/"
let LOCATIONS_URL = "http://knightrider.mgaitec.net:8080/ridesharing/locations/"
let MESSAGES_URL = "http://knightrider.mgaitec.net:8080/ridesharing/messages/"
let DEVICE_REGISTRATION_URL = "http://knightrider.mgaitec.net:8080/ridesharing/device"

let regularHeaders: HTTPHeaders = [
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "Cache-Control": "no-cache"
]






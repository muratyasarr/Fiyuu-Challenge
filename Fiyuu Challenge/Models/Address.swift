//
//  Address.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import Foundation

class Address: Codable {
    var id: String?
    var latitude: Double?
    var longitude: Double?
    var city: String?
    var county: String?
    var areas: [String]?
    var route: String?
    var estimationRouteNo: String?
    var routeNo: String?
    var estimationDetails: String?
    var details: String?
    var flat: String?
    var floor: String?
    var name: String?
    var direction: String?
    var summary: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case latitude = "lat"
        case longitude = "lng"
        case city
        case county
        case areas
        case route
        case estimationRouteNo
        case routeNo
        case estimationDetails
        case details
        case flat
        case floor
        case name
        case direction
        case summary
        
    }
}

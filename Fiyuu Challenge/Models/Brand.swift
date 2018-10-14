//
//  Brand.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import Foundation

class Brand: Codable {
    var id: String?
    var name: String?
    var imageURLPath: String?
    var address: Address?
    var productGroups: [ProductGroup]?
    var products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURLPath = "image"
        case address
        case productGroups
        case products
        
    }
}

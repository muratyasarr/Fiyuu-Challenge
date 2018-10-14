//
//  Product.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import Foundation

class Product: Codable {
    var id: String?
    var name: String?
    var productGroupId: String?
    var price: Int?
    var displayOrder: Int = 0
    var maximumQuantity: Int?
    var imagePaths: [String]?
    var summary: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case productGroupId
        case price
        case displayOrder
        case maximumQuantity
        case imagePaths = "images"
        case summary
    }
}

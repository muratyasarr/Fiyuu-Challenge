//
//  FiyuuResponseModel.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import Foundation

// To connect with multiple API's and adjust acc. to their response models.
class FiyuuResponseModel<T: Codable>: Codable {
    var code: String?
    var data: T?
}

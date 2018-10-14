//
//  AddressTableViewCell.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressCityCountyLabel: UILabel!
    @IBOutlet weak var addressDetailsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addressNameLabel.text = nil
        addressCityCountyLabel.text = nil
        addressDetailsLabel.text = nil
    }
    
}

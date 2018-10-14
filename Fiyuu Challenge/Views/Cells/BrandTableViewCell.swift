//
//  BrandTableViewCell.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell {
    
    @IBOutlet weak var brandCoverImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        brandNameLabel.text = nil
        brandCoverImageView.image = UIImage(named: "restaurant")
        brandCoverImageView.kf.cancelDownloadTask()
    }
}

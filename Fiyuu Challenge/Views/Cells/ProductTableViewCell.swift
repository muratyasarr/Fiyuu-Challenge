//
//  ProductTableViewCell.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.text = nil
        productDescriptionLabel.text = nil
        productImageView.image = nil
        productImageView.kf.cancelDownloadTask()
    }
}

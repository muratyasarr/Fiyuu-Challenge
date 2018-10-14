//
//  TableViewDataSource.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

// Reusable Data Source Models
class TableViewDataSource<Model, CellType: UITableViewCell>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurator = (Model, CellType) -> Void
    var models: [Model]
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model], cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellType.self), for: indexPath) as? CellType else { return UITableViewCell() }
        cellConfigurator(model, cell)
        cell.layoutIfNeeded()
        return cell
    }
}

class SectionedTableViewDataSource: NSObject, UITableViewDataSource {
    private let dataSources: [UITableViewDataSource]
    
    init(dataSources: [UITableViewDataSource]) {
        self.dataSources = dataSources
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, numberOfRowsInSection: 0)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = dataSources[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
}

// Reusable Data Sources
extension TableViewDataSource where Model == Brand, CellType == BrandTableViewCell {
    static func make(for brands: [Brand]) -> UITableViewDataSource {
        return TableViewDataSource(models: brands, cellConfigurator: { (brand, brandCell) in
            brandCell.brandNameLabel.text = brand.name
            if let imagePath = brand.imageURLPath, let imageURL = URL(string: imagePath) {
                brandCell.brandCoverImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "restaurant"), options: nil, progressBlock: nil) { (_, error, _, _) in
                    guard error == nil else {
                        brandCell.brandCoverImageView.image = UIImage(named: "restaurant")
                        return
                    }
                }
            }
        })
    }
}

// Reusable Data Sources
extension TableViewDataSource where Model == Product, CellType == ProductTableViewCell {
    static func make(for products: [Product]) -> UITableViewDataSource {
        return TableViewDataSource(models: products, cellConfigurator: { (product, productCell) in
            productCell.productNameLabel.text = product.name ?? "Ürün Adı"
            if let productDescription = product.summary {
                productCell.productDescriptionLabel.text = productDescription
            }
            if let imagePath = product.imagePaths?.first, let imageURL = URL(string: imagePath) {
                productCell.productImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "restaurant"), options: nil, progressBlock: nil) { (_, error, _, _) in
                    guard error == nil else {
                        productCell.productImageView.image = UIImage(named: "restaurant")
                        return
                    }
                }
            }
        })
    }
}

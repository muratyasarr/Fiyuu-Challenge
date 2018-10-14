//
//  BrandDetailsViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class BrandDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = UITableView.automaticDimension
            if let brand = self.brand {
                self.dataSources = SectionedTableViewDataSource(dataSources: [
                    TableViewDataSource.make(for: [brand])
                    ])
                self.tableView.dataSource = self.dataSources
                tableView.reloadData() // Reload on first opening with the initial brand model to make the lazy loading effect.
            }
        }
    }
    
    var brand: Brand?
    
    private var dataSources: SectionedTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareData()
    }
    
    private func prepareUI() {
        title = brand?.name ?? "Restoran Detayı"
    }
    
    private func prepareData() {
        guard let brandId = brand?.id else { return }
        NetworkManager().request(BrandsEndpoint.details(brandId: brandId)) { [weak self] (result: Result<FiyuuResponseModel<Brand>>) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.brand = result.data
                if let brand = self.brand, let products = self.brand?.products {
                    self.dataSources = SectionedTableViewDataSource(dataSources: [
                        TableViewDataSource.make(for: [brand]),
                        TableViewDataSource.make(for: products.sorted(by: {$0.displayOrder < $1.displayOrder})) // Better ordering is also possible by sorting relative to the product groups' displayOrder as well.
                    ])
                    self.tableView.dataSource = self.dataSources
                }
                self.tableView.reloadData()
            case .error(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

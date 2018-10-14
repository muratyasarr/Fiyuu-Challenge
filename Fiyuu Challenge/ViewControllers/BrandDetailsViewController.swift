//
//  BrandDetailsViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class BrandDetailsViewController: UIViewController {
    
    enum TableViewSectionIndexPaths: Int {
        case HeaderSection = 0
        case ProductsSection
    }
    
    @IBOutlet weak var tableView: UITableView!
    
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
                        TableViewDataSource.make(for: products)
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

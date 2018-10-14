//
//  BrandDetailsViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class BrandDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var brand: Brand?

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
            switch result {
            case .success(let result):
                self?.brand = result.data
                self?.tableView.reloadData()
                print("success result: \(result.data)")
            case .error(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

extension BrandDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

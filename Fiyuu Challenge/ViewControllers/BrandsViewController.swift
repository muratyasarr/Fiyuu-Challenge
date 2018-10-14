//
//  BrandsViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class BrandsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var brands: [Brand] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager().request(BrandsEndpoint.all) { (result: Result<FiyuuBrandsResponseModel>) in
            switch result {
            case .success(let result):
                self.brands = result.data ?? []
                print("result: \(result)")
            case .error(let error):
                print("error: \(error.localizedDescription)")
            }
        }
        
//        NetworkManager().request(BrandsEndpoint.details(brandId: "f5b049b1-c3ba-47b4-9198-ed29a33ee642")) { (result: Result<FiyuuResponseModel>) in
//            switch result {
//            case .success(let result):
//                print("result: \(result)")
//            case .error(let error):
//                print("error: \(error.localizedDescription)")
//            }
//        }
    }


}

extension BrandsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let brandCell = tableView.dequeueReusableCell(withIdentifier: String(describing: BrandTableViewCell.self), for: indexPath) as? BrandTableViewCell else { return UITableViewCell() }
        let brand = brands[indexPath.row]
        brandCell.brandNameLabel.text = brand.name
        return brandCell
    }
}

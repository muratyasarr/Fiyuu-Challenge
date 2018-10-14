//
//  BrandsViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit
import Kingfisher

class BrandsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.dataSource = self.dataSource
        }
    }
    
    var brands: [Brand] = [] {
        didSet {
            self.dataSource = TableViewDataSource.make(for: self.brands)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    var dataSource: UITableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareData()
    }
    
    private func prepareUI() {
        title = "Restoranlar"
    }
    
    private func prepareData() {
        NetworkManager().request(BrandsEndpoint.all) { [weak self] (result: Result<FiyuuResponseModel<[Brand]>>) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                guard let data = result.data else { return }
                self.brands = data
            case .error(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

extension BrandsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brand = brands[indexPath.row]
        guard let brandDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: BrandDetailsViewController.self)) as? BrandDetailsViewController else { return }
        brandDetailsViewController.brand = brand
        self.navigationController?.pushViewController(brandDetailsViewController, animated: true)
    }
}

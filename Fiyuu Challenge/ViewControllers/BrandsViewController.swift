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
        }
    }
    
    var brands: [Brand] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
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
            switch result {
            case .success(let result):
                guard let data = result.data else { return }
                self?.brands = data
            case .error(let error):
                print("error: \(error.localizedDescription)")
            }
        }
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
        if let imagePath = brand.imageURLPath, let imageURL = URL(string: imagePath) {
            brandCell.brandCoverImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "restaurant"), options: nil, progressBlock: nil) { (_, error, _, _) in
                guard error == nil else {
                    brandCell.brandCoverImageView.image = UIImage(named: "restaurant")
                    return
                }
            }
        }
        return brandCell
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

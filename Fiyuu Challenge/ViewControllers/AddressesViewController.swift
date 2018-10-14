//
//  AddressesViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit

class AddressesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var addresses: [Address] = []  {
        didSet {
            self.dataSource = TableViewDataSource.make(for: addresses)
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
        title = "Adreslerim"
    }
    
    private func prepareData() {
        NetworkManager().request(AddressEndpoint.all) { [weak self] (result: Result<FiyuuResponseModel<[Address]>>) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                guard let data = result.data else { return }
                self.addresses = data
            case .error(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

extension AddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let address = addresses[indexPath.row]
        guard let addressOnMapViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AddressOnMapViewController.self)) as? AddressOnMapViewController else { return }
        addressOnMapViewController.address = address
        self.navigationController?.pushViewController(addressOnMapViewController, animated: true)
    }
}

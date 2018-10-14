//
//  AddressOnMapViewController.swift
//  Fiyuu Challenge
//
//  Created by Guest User on 14.10.2018.
//  Copyright © 2018 Guest User. All rights reserved.
//

import UIKit
import MapKit

class AddressOnMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    var address: Address?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    private func prepareUI() {
        guard let address = address else { return }
        title = address.name
        mapView.showsCompass = true
        mapView.showsScale = true
        let annotation = MKPointAnnotation()
        annotation.title = address.name
        annotation.subtitle = address.county
        if let latitude = address.latitude, let longitude = address.longitude {
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
    }

}

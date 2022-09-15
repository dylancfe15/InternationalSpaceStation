//
//  ViewController.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import UIKit

final class MapViewController: UIViewController {

    private lazy var mapView = MapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


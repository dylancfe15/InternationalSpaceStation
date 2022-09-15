//
//  ViewController.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import UIKit
import Combine

final class MapViewController: UIViewController {

    private lazy var mapView = MapView()
    private var locationPublisher: AnyCancellable?
    private let viewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        configurePublisher()

        viewModel.fetchInternationalSpaceStationCurrentLocation()
    }

    deinit {
        locationPublisher?.cancel()
    }

    private func configurePublisher() {
        locationPublisher = viewModel.locationSubject.eraseToAnyPublisher().sink(receiveValue: { [weak self] response in
            self?.mapView.updateLocation(with: response)
        })
    }
}


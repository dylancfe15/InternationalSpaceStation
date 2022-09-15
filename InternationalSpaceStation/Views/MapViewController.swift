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

    private lazy var focusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didFocusButtonOnTap), for: .touchUpInside)
        button.setImage(UIImage(named: "focus"), for: .normal)
        button.backgroundColor = .white
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])

        return button
    }()

    private var locationPublisher: AnyCancellable?
    private let viewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        view.addSubview(focusButton)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            focusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
            focusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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

    @objc private func didFocusButtonOnTap() {
        mapView.shouldFocusOnISS.toggle()

        focusButton.alpha = mapView.shouldFocusOnISS ? 1 : 0.5
    }
}


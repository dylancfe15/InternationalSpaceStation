//
//  MapView.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import UIKit
import MapKit

protocol MapViewUpdatable {
    func updateLocation(with response: ISSLocationResponse)
}

final class MapView: MKMapView {

    private lazy var annotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "International Space Station"
        return annotation
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        addAnnotation(annotation)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView: MapViewUpdatable {
    func updateLocation(with response: ISSLocationResponse) {
        guard let latitude = response.iss_position?.latitude,
              let longitude = response.iss_position?.longitude else { return }

        let coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)

        UIView.animate(withDuration: 1) {
            self.annotation.coordinate = coordinate
        }
    }
}

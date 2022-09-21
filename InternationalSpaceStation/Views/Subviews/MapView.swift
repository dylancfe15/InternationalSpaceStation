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

    var shouldFocusOnISS = true

    private lazy var annotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "International Space Station"
        return annotation
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        delegate = self

        addAnnotation(annotation)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func focusOnISS() {
        guard shouldFocusOnISS else { return }

        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)

        setRegion(region, animated: true)
    }
}

// MARK: - MapViewUpdatable

extension MapView: MapViewUpdatable {

    /// Update the location of the pin with the response
    /// - Parameter response: reponse of the ISS location
    func updateLocation(with response: ISSLocationResponse) {
        guard let latitude = response.iss_position?.latitude,
              let longitude = response.iss_position?.longitude else { return }

        let coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 3) {
                self.annotation.coordinate = coordinate
            }

            self.focusOnISS()
        }
    }
}

// MARK: - MKMapViewDelegate

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "space_station"
        var annotationView: MKAnnotationView?

        if let dequeuedAnnotationView = dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }

        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "space_station")
        }

        annotationView?.frame = CGRect(origin: .zero, size: CGSize(width: 35, height: 35))

        return annotationView
    }
}

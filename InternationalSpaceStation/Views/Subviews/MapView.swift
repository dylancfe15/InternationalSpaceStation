//
//  MapView.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import UIKit
import MapKit

final class MapView: MKMapView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

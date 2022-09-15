//
//  MapViewModel.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import Foundation
import Combine
import CoreLocation

final class MapViewModel {

    let locationSubject = PassthroughSubject<ISSLocationResponse, Never>()
    var dataManager: MapDataManaging = MapDataManager()

    func fetchInternationalSpaceStationCurrentLocation() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] timer in
            self?.dataManager.fetchInternationalSpaceStationCurrentLocation { [weak self] response, error in
                guard let response = response, let `self` = self else {
                    return
                }

                self.locationSubject.send(response)
            }
        }
    }
}

//
//  MockDataManager.swift
//  InternationalSpaceStationTests
//
//  Created by Difeng Chen on 9/15/22.
//

import Foundation
@testable import InternationalSpaceStation

final class MockDataManager: MapDataManaging {
    func fetchInternationalSpaceStationCurrentLocation(completion: @escaping (ISSLocationResponse?, Error?) -> Void) {
        if let url = Bundle(for: MapViewModelTests.self).url(forResource: "iss-now", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let response = try JSONDecoder().decode(ISSLocationResponse.self, from: data)

                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}

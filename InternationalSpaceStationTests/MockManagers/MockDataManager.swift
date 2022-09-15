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
        if let path = Bundle.main.path(forResource: "iss-now", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode(ISSLocationResponse.self, from: data)

                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}

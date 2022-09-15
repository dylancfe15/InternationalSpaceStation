//
//  MapDataManager.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import Foundation

protocol MapDataManaging {
    func fetchInternationalSpaceStationCurrentLocation(completion: @escaping(_ response: ISSLocationResponse?, _ error: Error?) -> Void)
}

final class MapDataManager: MapDataManaging {
    func fetchInternationalSpaceStationCurrentLocation(completion: @escaping(_ response: ISSLocationResponse?, _ error: Error?) -> Void) {
        guard let url = URL(string: "http://api.open-notify.org/iss-now.json") else {
            completion(nil, AppError.invalidURL)
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(ISSLocationResponse.self, from: data)

                completion(decodedResponse, nil)
            } catch let error {
                completion(nil, error)
            }
        }

        task.resume()
    }
}

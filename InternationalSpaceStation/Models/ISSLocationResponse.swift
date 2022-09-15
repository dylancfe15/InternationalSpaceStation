//
//  ISSLocationResponse.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import Foundation

struct ISSLocationResponse: Decodable {
    struct Position: Decodable {
        let latitude: Double?
        let longitude: Double?
    }

    let message: String?
    let timestamp: Double?
    let iss_position: Position?
}

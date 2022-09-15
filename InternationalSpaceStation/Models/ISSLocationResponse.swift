//
//  ISSLocationResponse.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/14/22.
//

import Foundation

struct ISSLocationResponse: Decodable {
    struct Position: Decodable {
        let latitude: String?
        let longitude: String?
    }

    let message: String?
    let timestamp: Double?
    let iss_position: Position?
}

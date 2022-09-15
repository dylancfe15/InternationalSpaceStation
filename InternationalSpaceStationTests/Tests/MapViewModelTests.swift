//
//  MapViewModelTests.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/15/22.
//

import XCTest
@testable import InternationalSpaceStation

final class MapViewModelTests: XCTestCase {
    var viewModel: MapViewModel!

    override func setUp() {
        super.setUp()

        viewModel = MapViewModel()
        viewModel.dataManager = MockDataManager()
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
    }

    func testFetchInternationalSpaceStationCurrentLocation() {
        viewModel.fetchInternationalSpaceStationCurrentLocation()
    }
}

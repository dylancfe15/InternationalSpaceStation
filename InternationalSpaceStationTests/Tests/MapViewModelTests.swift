//
//  MapViewModelTests.swift
//  InternationalSpaceStation
//
//  Created by Difeng Chen on 9/15/22.
//

import XCTest
import Combine
@testable import InternationalSpaceStation

final class MapViewModelTests: XCTestCase {
    private var viewModel: MapViewModel!
    private var locationPublisher: AnyCancellable!
    private var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()

        viewModel = MapViewModel()
        viewModel.dataManager = MockDataManager()
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        locationPublisher?.cancel()
    }

    func testFetchInternationalSpaceStationCurrentLocation() {
        expectation = expectation(description: "expectation")

        locationPublisher = viewModel.locationSubject.eraseToAnyPublisher().sink(receiveValue: { [weak self] response in
            XCTAssertEqual(response.message, "success")

            self?.expectation.fulfill()
        })

        viewModel.fetchInternationalSpaceStationCurrentLocation()

        waitForExpectations(timeout: 3)
    }
}

//
//  RatingInfoDashboardRouterTests.swift
//  AppStoreClone
//
//  Created by YD on 6/17/24.
//

@testable import AppDetailsImp
import XCTest

final class RatingInfoDashboardRouterTests: XCTestCase {

    private var sut: RatingInfoDashboardRouter!

    override func setUp() {
        super.setUp()
        
        self.sut = RatingInfoDashboardRouter(
            interactor: RatingInfoDashboardInteractableMock(),
            viewController: RatinginfoDashboardViewControllableMock()
        )
    }

    // MARK: - Tests
    func testDidLoad() {
        sut.didLoad()
    }
}

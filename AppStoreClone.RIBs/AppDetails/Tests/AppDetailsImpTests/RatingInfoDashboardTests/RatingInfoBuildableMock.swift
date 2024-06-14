//
//  RatingInfoBuildableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import Foundation
import RIBsTestSupport
@testable import AppDetailsImp

final class RatingInfoBuildableMock: RatingInfoDashboardBuildable {
    var buildHandler: ((_ listener: RatingInfoDashboardListener) -> RatingInfoDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: RatingInfoDashboardListener) -> RatingInfoDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class RatingInfoRoutingMock: ViewableRoutingMock, RatingInfoDashboardRouting {
    
}

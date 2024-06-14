//
//  TopInfoBuildableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import Foundation
import RIBsTestSupport
@testable import AppDetailsImp

final class TopInfoBuildableMock: TopInfoDashboardBuildable {
    var buildHandler: ((_ listener: TopInfoDashboardListener) -> TopInfoDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: TopInfoDashboardListener) -> TopInfoDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class TopInfoDashboardRoutingMock: ViewableRoutingMock, TopInfoDashboardRouting {
    
}

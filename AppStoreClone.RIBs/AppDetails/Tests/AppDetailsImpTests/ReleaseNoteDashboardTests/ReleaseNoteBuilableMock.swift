//
//  ReleaseNoteBuilableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import Foundation
import RIBsTestSupport
@testable import AppDetailsImp

final class ReleaseNoteBuildableMock: ReleaseNoteDashboardBuildable {
    var buildHandler: ((_ listener: ReleaseNoteDashboardListener) -> ReleaseNoteDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: ReleaseNoteDashboardListener) -> ReleaseNoteDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class ReleaseNoteRoutingMock: ViewableRoutingMock, ReleaseNoteDashboardRouting {
    
}

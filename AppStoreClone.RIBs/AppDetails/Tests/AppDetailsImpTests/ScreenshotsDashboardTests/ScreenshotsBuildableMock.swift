//
//  ScreenshotsBuildableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import Foundation
import RIBsTestSupport
@testable import AppDetailsImp

final class ScreenshotsBuildableMock: ScreenshotsDashboardBuildable {
    var buildHandler: ((_ listener: ScreenshotsDashboardListener) -> ScreenshotsDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: ScreenshotsDashboardListener) -> ScreenshotsDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class ScreenshotsRoutingMock: ViewableRoutingMock, ScreenshotsDashboardRouting {
    
}

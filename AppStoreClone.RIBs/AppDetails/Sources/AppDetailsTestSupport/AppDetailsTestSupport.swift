//
//  AppDetailsTestSupport.swift
//
//
//  Created by YD on 6/17/24.
//

import Foundation
import AppDetails
import AppDetailsImp
import RIBs
import Entities
import RIBsTestSupport

public final class AppDetailsBuildableMock: AppDetailsBuildable {
    public var buildHandler: ((_ listener: AppDetailsListener) -> ViewableRouting)?
    
    public var buildCallCount = 0
    public var buildInfo: AppPreviewInfo?
    public func build(withListener listener: AppDetailsListener, info: AppPreviewInfo) -> ViewableRouting {
        buildCallCount += 1
        buildInfo = info
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
    
    public init() { }
}

public final class AppDetailsRoutingMock: ViewableRoutingMock, AppDetailsRouting {
    public var attachTopInfoDashboardCallCount = 0
    public func attachTopInfoDashboard() {
        attachTopInfoDashboardCallCount += 1
    }
    
    public var attachRatingInfoDashboardCallCount = 0
    public func attachRatingInfoDashboard() {
        attachRatingInfoDashboardCallCount += 1
    }
    
    public var attachReleaseNoteDashboardCallCount = 0
    public func attachReleaseNoteDashboard() {
        attachReleaseNoteDashboardCallCount += 1
    }
    
    public var attachScreenshotsDashboardCallCount = 0
    public func attachScreenshotsDashboard() {
        attachScreenshotsDashboardCallCount += 1
    }
}

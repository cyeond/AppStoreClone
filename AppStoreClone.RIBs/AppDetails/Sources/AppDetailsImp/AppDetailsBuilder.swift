//
//  AppDetailsBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import RxSwift
import Entities
import AppDetails

public protocol AppDetailsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppDetailsComponent: Component<AppDetailsDependency>, TopInfoDashboardDependency, RatingInfoDashboardDependency, ScreenshotsDashboardDependency, ReleaseNoteDashboardDependency {
    let appPreviewInfo: AppPreviewInfo
    let appDetailsRepository: AppDetailsRepository
    
    init(dependency: AppDetailsDependency, appPreviewInfo: AppPreviewInfo) {
        self.appPreviewInfo = appPreviewInfo
        self.appDetailsRepository = AppDetailsRepositoryImp(appId: appPreviewInfo.id)
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
public final class AppDetailsBuilder: Builder<AppDetailsDependency>, AppDetailsBuildable {
    public override init(dependency: AppDetailsDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: AppDetailsListener, info: AppPreviewInfo) -> ViewableRouting {
        let component = AppDetailsComponent(dependency: dependency, appPreviewInfo: info)
        let viewController = AppDetailsViewController()
        let interactor = AppDetailsInteractor(presenter: viewController)
        interactor.listener = listener
        
        let topInfoDashboardBuilder = TopInfoDashboardBuilder(dependency: component)
        let ratingInfoDashboardBuilder = RatingInfoDashboardBuilder(dependency: component)
        let screenshotsDashboardBuilder = ScreenshotsDashboardBuilder(dependency: component)
        let releaseNoteDashboardBuilder = ReleaseNoteDashboardBuilder(dependency: component)
        
        return AppDetailsRouter(
            interactor: interactor,
            viewController: viewController,
            topInfoDashboardBuilable: topInfoDashboardBuilder,
            ratingInfoDashboardBuilable: ratingInfoDashboardBuilder,
            screenshotsDashboardBuildable: screenshotsDashboardBuilder,
            releaseNoteDashboardBuildable: releaseNoteDashboardBuilder
        )
    }
}

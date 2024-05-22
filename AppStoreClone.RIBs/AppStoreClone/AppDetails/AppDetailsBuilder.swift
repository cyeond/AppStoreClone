//
//  AppDetailsBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import RxSwift

protocol AppDetailsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppDetailsComponent: Component<AppDetailsDependency>, TopInfoDashboardDependency, RatingInfoDashboardDependency, ScreenshotsDashboardDependency, ReleaseNoteDashboardDependency {
    let appPreviewInfo: AppPreviewInfo
    let appInfoObservable: Observable<AppInfo>
    
    init(dependency: AppDetailsDependency, appPreviewInfo: AppPreviewInfo) {
        self.appPreviewInfo = appPreviewInfo
        self.appInfoObservable = API.lookup(appPreviewInfo.id).subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).asObservable().share(replay: 1)
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol AppDetailsBuildable: Buildable {
    func build(withListener listener: AppDetailsListener, info: AppPreviewInfo) -> AppDetailsRouting
}

final class AppDetailsBuilder: Builder<AppDetailsDependency>, AppDetailsBuildable {
    override init(dependency: AppDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppDetailsListener, info: AppPreviewInfo) -> AppDetailsRouting {
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

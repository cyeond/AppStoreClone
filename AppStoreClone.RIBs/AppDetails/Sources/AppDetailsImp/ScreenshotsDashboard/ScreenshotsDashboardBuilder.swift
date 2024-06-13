//
//  ScreenshotsDashboardBuilder.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs
import RxSwift

protocol ScreenshotsDashboardDependency: Dependency {
    var appDetailsRepository: AppDetailsRepository { get }
}

final class ScreenshotsDashboardComponent: Component<ScreenshotsDashboardDependency>, ScreenshotsDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository { dependency.appDetailsRepository }
}

// MARK: - Builder

protocol ScreenshotsDashboardBuildable: Buildable {
    func build(withListener listener: ScreenshotsDashboardListener) -> ScreenshotsDashboardRouting
}

final class ScreenshotsDashboardBuilder: Builder<ScreenshotsDashboardDependency>, ScreenshotsDashboardBuildable {

    override init(dependency: ScreenshotsDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ScreenshotsDashboardListener) -> ScreenshotsDashboardRouting {
        let component = ScreenshotsDashboardComponent(dependency: dependency)
        let viewController = ScreenshotsDashboardViewController()
        let interactor = ScreenshotsDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ScreenshotsDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

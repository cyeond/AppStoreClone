//
//  ScreenshotsDashboardBuilder.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs

protocol ScreenshotsDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ScreenshotsDashboardComponent: Component<ScreenshotsDashboardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let interactor = ScreenshotsDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return ScreenshotsDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

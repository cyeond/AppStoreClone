//
//  ReleaseNoteDashboardBuilder.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs

protocol ReleaseNoteDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ReleaseNoteDashboardComponent: Component<ReleaseNoteDashboardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ReleaseNoteDashboardBuildable: Buildable {
    func build(withListener listener: ReleaseNoteDashboardListener) -> ReleaseNoteDashboardRouting
}

final class ReleaseNoteDashboardBuilder: Builder<ReleaseNoteDashboardDependency>, ReleaseNoteDashboardBuildable {

    override init(dependency: ReleaseNoteDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ReleaseNoteDashboardListener) -> ReleaseNoteDashboardRouting {
        let component = ReleaseNoteDashboardComponent(dependency: dependency)
        let viewController = ReleaseNoteDashboardViewController()
        let interactor = ReleaseNoteDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return ReleaseNoteDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

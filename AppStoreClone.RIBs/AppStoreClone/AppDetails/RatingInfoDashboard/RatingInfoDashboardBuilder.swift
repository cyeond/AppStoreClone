//
//  RatingInfoDashboardBuilder.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import RIBs

protocol RatingInfoDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RatingInfoDashboardComponent: Component<RatingInfoDashboardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RatingInfoDashboardBuildable: Buildable {
    func build(withListener listener: RatingInfoDashboardListener) -> RatingInfoDashboardRouting
}

final class RatingInfoDashboardBuilder: Builder<RatingInfoDashboardDependency>, RatingInfoDashboardBuildable {

    override init(dependency: RatingInfoDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RatingInfoDashboardListener) -> RatingInfoDashboardRouting {
        let component = RatingInfoDashboardComponent(dependency: dependency)
        let viewController = RatingInfoDashboardViewController()
        let interactor = RatingInfoDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return RatingInfoDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

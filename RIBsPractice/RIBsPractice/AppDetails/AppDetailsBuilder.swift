//
//  AppDetailsBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs

protocol AppDetailsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppDetailsComponent: Component<AppDetailsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppDetailsBuildable: Buildable {
    func build(withListener listener: AppDetailsListener) -> AppDetailsRouting
}

final class AppDetailsBuilder: Builder<AppDetailsDependency>, AppDetailsBuildable {

    override init(dependency: AppDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppDetailsListener) -> AppDetailsRouting {
        let component = AppDetailsComponent(dependency: dependency)
        let viewController = AppDetailsViewController()
        let interactor = AppDetailsInteractor(presenter: viewController)
        interactor.listener = listener
        return AppDetailsRouter(interactor: interactor, viewController: viewController)
    }
}

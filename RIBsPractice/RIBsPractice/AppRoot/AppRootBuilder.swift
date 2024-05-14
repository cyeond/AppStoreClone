//
//  AppRootBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        _ = AppRootComponent(dependency: dependency)
        let tabBar = RootTabBarController()
        let interactor = AppRootInteractor(presenter: tabBar)
        
        let router = AppRootRouter(interactor: interactor, viewController: tabBar)
        
        return router
    }
}

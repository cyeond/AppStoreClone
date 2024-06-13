//
//  AppRootBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import AppsHome

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
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
        let component = AppRootComponent(dependency: dependency)
        let tabBar = RootTabBarController()
        let interactor = AppRootInteractor(presenter: tabBar)
        
        let appsHome = AppsHomeBuilder(dependency: component)
        let searchHome = SearchHomeBuilder(dependency: component)
        
        let router = AppRootRouter(
            interactor: interactor,
            viewController: tabBar,
            appsHome: appsHome,
            searchHome: searchHome
        )
        
        return router
    }
}

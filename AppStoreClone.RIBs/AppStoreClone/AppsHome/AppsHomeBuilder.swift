//
//  AppsHomeBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol AppsHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppsHomeComponent: Component<AppsHomeDependency>, ShowAllAppsDependency, AppDetailsDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppsHomeBuildable: Buildable {
    func build(withListener listener: AppsHomeListener) -> AppsHomeRouting
}

final class AppsHomeBuilder: Builder<AppsHomeDependency>, AppsHomeBuildable {

    override init(dependency: AppsHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppsHomeListener) -> AppsHomeRouting {
        let component = AppsHomeComponent(dependency: dependency)
        let viewController = AppsHomeViewController()
        let interactor = AppsHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let showAllAppsBuilder = ShowAllAppsBuilder(dependency: component)
        let appDetailsBuilder = AppDetailsBuilder(dependency: component)
        
        return AppsHomeRouter(
            interactor: interactor,
            viewController: viewController,
            showAllAppsBuildable: showAllAppsBuilder,
            appDetailsBuildable: appDetailsBuilder
        )
    }
}

//
//  AppsHomeBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import AppDetails
import ShowAllApps

public protocol AppsHomeDependency: Dependency {
    var appDetailsBuildable: AppDetailsBuildable { get }
    var showAllAppsBuildable: ShowAllAppsBuildable { get }
}

final class AppsHomeComponent: Component<AppsHomeDependency> {
    var appDetailsBuildable: AppDetailsBuildable { dependency.appDetailsBuildable }
    var showAllAppsBuildable: ShowAllAppsBuildable { dependency.showAllAppsBuildable }
}

// MARK: - Builder

public protocol AppsHomeBuildable: Buildable {
    func build(withListener listener: AppsHomeListener) -> ViewableRouting
}

public final class AppsHomeBuilder: Builder<AppsHomeDependency>, AppsHomeBuildable {

    public override init(dependency: AppsHomeDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: AppsHomeListener) -> ViewableRouting {
        let component = AppsHomeComponent(dependency: dependency)
        let viewController = AppsHomeViewController()
        let interactor = AppsHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        return AppsHomeRouter(
            interactor: interactor,
            viewController: viewController,
            showAllAppsBuildable: component.showAllAppsBuildable,
            appDetailsBuildable: component.appDetailsBuildable
        )
    }
}

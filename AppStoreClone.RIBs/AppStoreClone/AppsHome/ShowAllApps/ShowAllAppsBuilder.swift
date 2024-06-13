//
//  ShowAllAppsBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import ReuseableViews

protocol ShowAllAppsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ShowAllAppsComponent: Component<ShowAllAppsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ShowAllAppsBuildable: Buildable {
    func build(withListener listener: ShowAllAppsListener, sectionModel: CollectionViewSectionModel) -> ShowAllAppsRouting
}

final class ShowAllAppsBuilder: Builder<ShowAllAppsDependency>, ShowAllAppsBuildable {
    override init(dependency: ShowAllAppsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ShowAllAppsListener, sectionModel: CollectionViewSectionModel) -> ShowAllAppsRouting {
        _ = ShowAllAppsComponent(dependency: dependency)
        let viewController = ShowAllAppsViewController()
        let interactor = ShowAllAppsInteractor(presenter: viewController, sectionModel: sectionModel)
        interactor.listener = listener
        return ShowAllAppsRouter(interactor: interactor, viewController: viewController)
    }
}

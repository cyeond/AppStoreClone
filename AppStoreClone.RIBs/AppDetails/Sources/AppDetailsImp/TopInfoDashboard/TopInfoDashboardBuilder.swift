//
//  TopInfoDashboardBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/18/24.
//

import RIBs
import Entities
import Extensions

protocol TopInfoDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var appPreviewInfo: AppPreviewInfo { get }
    var uiApplication: UIApplicationProtocol { get }
}

final class TopInfoDashboardComponent: Component<TopInfoDashboardDependency>, TopInfoDashboardInteractorDependency {
    var appPreviewInfo: AppPreviewInfo { dependency.appPreviewInfo }
    var uiApplication: UIApplicationProtocol { dependency.uiApplication }
}

// MARK: - Builder

protocol TopInfoDashboardBuildable: Buildable {
    func build(withListener listener: TopInfoDashboardListener) -> TopInfoDashboardRouting
}

final class TopInfoDashboardBuilder: Builder<TopInfoDashboardDependency>, TopInfoDashboardBuildable {

    override init(dependency: TopInfoDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TopInfoDashboardListener) -> TopInfoDashboardRouting {
        let component = TopInfoDashboardComponent(dependency: dependency)
        let viewController = TopInfoDashboardViewController()
        let interactor = TopInfoDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return TopInfoDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

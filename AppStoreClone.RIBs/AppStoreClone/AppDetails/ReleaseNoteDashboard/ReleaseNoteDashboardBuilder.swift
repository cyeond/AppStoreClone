//
//  ReleaseNoteDashboardBuilder.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs
import RxSwift

protocol ReleaseNoteDashboardDependency: Dependency {
    var appInfoObservable: Observable<AppInfo> { get }
}

final class ReleaseNoteDashboardComponent: Component<ReleaseNoteDashboardDependency>,ReleaseNoteDashboardInteractorDependency {
    var appInfoObservable: Observable<AppInfo> { dependency.appInfoObservable }
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
        let interactor = ReleaseNoteDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ReleaseNoteDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

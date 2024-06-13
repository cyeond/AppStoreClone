//
//  RatingInfoDashboardBuilder.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import RIBs
import RxSwift

protocol RatingInfoDashboardDependency: Dependency {
    var appDetailsRepository: AppDetailsRepository { get }
}

final class RatingInfoDashboardComponent: Component<RatingInfoDashboardDependency>, RatingInfoDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository { dependency.appDetailsRepository }
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
        let interactor = RatingInfoDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return RatingInfoDashboardRouter(interactor: interactor, viewController: viewController)
    }
}

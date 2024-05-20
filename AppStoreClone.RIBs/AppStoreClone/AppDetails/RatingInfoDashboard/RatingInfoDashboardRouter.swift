//
//  RatingInfoDashboardRouter.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import RIBs

protocol RatingInfoDashboardInteractable: Interactable {
    var router: RatingInfoDashboardRouting? { get set }
    var listener: RatingInfoDashboardListener? { get set }
}

protocol RatingInfoDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RatingInfoDashboardRouter: ViewableRouter<RatingInfoDashboardInteractable, RatingInfoDashboardViewControllable>, RatingInfoDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RatingInfoDashboardInteractable, viewController: RatingInfoDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

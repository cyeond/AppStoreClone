//
//  TopInfoDashboardRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/18/24.
//

import RIBs

protocol TopInfoDashboardInteractable: Interactable {
    var router: TopInfoDashboardRouting? { get set }
    var listener: TopInfoDashboardListener? { get set }
}

protocol TopInfoDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TopInfoDashboardRouter: ViewableRouter<TopInfoDashboardInteractable, TopInfoDashboardViewControllable>, TopInfoDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TopInfoDashboardInteractable, viewController: TopInfoDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

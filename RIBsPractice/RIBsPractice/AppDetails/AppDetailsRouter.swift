//
//  AppDetailsRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs

protocol AppDetailsInteractable: Interactable {
    var router: AppDetailsRouting? { get set }
    var listener: AppDetailsListener? { get set }
}

protocol AppDetailsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AppDetailsRouter: ViewableRouter<AppDetailsInteractable, AppDetailsViewControllable>, AppDetailsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AppDetailsInteractable, viewController: AppDetailsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  ReleaseNoteDashboardRouter.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs

protocol ReleaseNoteDashboardInteractable: Interactable {
    var router: ReleaseNoteDashboardRouting? { get set }
    var listener: ReleaseNoteDashboardListener? { get set }
}

protocol ReleaseNoteDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ReleaseNoteDashboardRouter: ViewableRouter<ReleaseNoteDashboardInteractable, ReleaseNoteDashboardViewControllable>, ReleaseNoteDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ReleaseNoteDashboardInteractable, viewController: ReleaseNoteDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  AppsHomeRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol AppsHomeInteractable: Interactable {
    var router: AppsHomeRouting? { get set }
    var listener: AppsHomeListener? { get set }
}

protocol AppsHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AppsHomeRouter: ViewableRouter<AppsHomeInteractable, AppsHomeViewControllable>, AppsHomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AppsHomeInteractable, viewController: AppsHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  ShowAllAppsRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs

protocol ShowAllAppsInteractable: Interactable {
    var router: ShowAllAppsRouting? { get set }
    var listener: ShowAllAppsListener? { get set }
}

protocol ShowAllAppsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ShowAllAppsRouter: ViewableRouter<ShowAllAppsInteractable, ShowAllAppsViewControllable>, ShowAllAppsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ShowAllAppsInteractable, viewController: ShowAllAppsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  SearchHomeRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol SearchHomeInteractable: Interactable {
    var router: SearchHomeRouting? { get set }
    var listener: SearchHomeListener? { get set }
}

protocol SearchHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchHomeRouter: ViewableRouter<SearchHomeInteractable, SearchHomeViewControllable>, SearchHomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchHomeInteractable, viewController: SearchHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

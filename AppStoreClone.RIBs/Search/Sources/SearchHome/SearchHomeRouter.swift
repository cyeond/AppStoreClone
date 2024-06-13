//
//  SearchHomeRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import AppDetails
import Entities

protocol SearchHomeInteractable: Interactable, AppDetailsListener {
    var router: SearchHomeRouting? { get set }
    var listener: SearchHomeListener? { get set }
}

protocol SearchHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchHomeRouter: ViewableRouter<SearchHomeInteractable, SearchHomeViewControllable>, SearchHomeRouting {
    private let appDetailsBuildable: AppDetailsBuildable
    private var appDetailsRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SearchHomeInteractable, viewController: SearchHomeViewControllable, appDetailsBuildable: AppDetailsBuildable) {
        self.appDetailsBuildable = appDetailsBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - AppDetails
    func attachAppDetails(with info: AppPreviewInfo) {
        guard appDetailsRouting == nil else { return }
        
        let router = appDetailsBuildable.build(withListener: interactor, info: info)
        viewControllable.pushViewController(router.viewControllable, animated: false)
        
        self.appDetailsRouting = router
        attachChild(router)
    }
    
    func detachAppDetails() {
        guard let router = appDetailsRouting else { return }
        
        viewControllable.popViewController(animated: false)
        
        self.appDetailsRouting = nil
        detachChild(router)
    }
}

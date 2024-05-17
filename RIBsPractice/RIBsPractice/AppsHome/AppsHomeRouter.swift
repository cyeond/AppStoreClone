//
//  AppsHomeRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol AppsHomeInteractable: Interactable, ShowAllAppsListener {
    var router: AppsHomeRouting? { get set }
    var listener: AppsHomeListener? { get set }
}

protocol AppsHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AppsHomeRouter: ViewableRouter<AppsHomeInteractable, AppsHomeViewControllable>, AppsHomeRouting {
    private let showAllAppsBuildable: ShowAllAppsBuildable
    private var showAllAppsRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: AppsHomeInteractable,
        viewController: AppsHomeViewControllable,
        showAllAppsBuildable: ShowAllAppsBuildable
    ) {
        self.showAllAppsBuildable = showAllAppsBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - ShowAllApps
    func attachShowAllApps(with sectionModel: CollectionViewSectionModel) {
        guard showAllAppsRouting == nil else { return }
        
        let router = showAllAppsBuildable.build(withListener: interactor, sectionModel: sectionModel)
        viewControllable.pushViewController(router.viewControllable, animated: false)
        
        attachChild(router)
        showAllAppsRouting = router
    }
    
    func detachShowAllApps() {
        guard let router = showAllAppsRouting else { return }
        
        viewControllable.popViewController(animated: false)
        
        detachChild(router)
        showAllAppsRouting = nil
    }
}

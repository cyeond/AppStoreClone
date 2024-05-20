//
//  AppRootRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol AppRootInteractable: Interactable, AppsHomeListener, SearchHomeListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    private let appsHome: AppsHomeBuildable
    private var appsHomeRouting: AppsHomeRouting?
    
    private let searchHome: SearchHomeBuildable
    private var searchHomeRouting: SearchHomeRouting?
    
    init(interactor: AppRootInteractable,
         viewController: AppRootViewControllable,
         appsHome: AppsHomeBuildable,
         searchHome: SearchHomeBuildable
    ) {
        self.appsHome = appsHome
        self.searchHome = searchHome
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        let appsHomeRouting = appsHome.build(withListener: interactor)
        let searchHomeRouting = searchHome.build(withListener: interactor)
        
        attachChild(appsHomeRouting)
        attachChild(searchHomeRouting)
        
        let viewControllers = [
            NavigationControllerable(root: appsHomeRouting.viewControllable),
            NavigationControllerable(root: searchHomeRouting.viewControllable)
        ]
        
        viewController.setViewControllers(viewControllers)
    }
}

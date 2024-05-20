//
//  AppDetailsRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs

protocol AppDetailsInteractable: Interactable, TopInfoDashboardListener, RatingInfoDashboardListener {
    var router: AppDetailsRouting? { get set }
    var listener: AppDetailsListener? { get set }
}

protocol AppDetailsViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class AppDetailsRouter: ViewableRouter<AppDetailsInteractable, AppDetailsViewControllable>, AppDetailsRouting {
    private let topInfoDashboardBuildable: TopInfoDashboardBuildable
    private var topInfoDashboardRouting: Routing?
    
    private let ratingInfoDashboardBuildable: RatingInfoDashboardBuildable
    private var ratingInfoDashboardRouting: Routing?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AppDetailsInteractable, 
         viewController: AppDetailsViewControllable,
         topInfoDashboardBuilable: TopInfoDashboardBuildable,
         ratingInfoDashboardBuilable: RatingInfoDashboardBuildable
    ) {
        self.topInfoDashboardBuildable = topInfoDashboardBuilable
        self.ratingInfoDashboardBuildable = ratingInfoDashboardBuilable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTopInfoDashboard() {
        guard topInfoDashboardRouting == nil else { return }
        
        let router = topInfoDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(router.viewControllable)
        attachChild(router)
        
        self.topInfoDashboardRouting = router
    }
    
    func attachRatingInfoDashboard() {
        guard ratingInfoDashboardRouting == nil else { return }
        
        let router = ratingInfoDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(router.viewControllable)
        attachChild(router)
        
        self.ratingInfoDashboardRouting = router
    }
}

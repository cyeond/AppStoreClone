//
//  AppDetailsRouter.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import AppDetails

protocol AppDetailsInteractable: Interactable, TopInfoDashboardListener, RatingInfoDashboardListener, ScreenshotsDashboardListener, ReleaseNoteDashboardListener {
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
    
    private let screenshotsDashboardBuildable: ScreenshotsDashboardBuildable
    private var screenshotsDashboardRouting: Routing?
    
    private let releaseNoteDashboardBuildable: ReleaseNoteDashboardBuildable
    private var releaseNoteDashboardRouting: Routing?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AppDetailsInteractable, 
         viewController: AppDetailsViewControllable,
         topInfoDashboardBuilable: TopInfoDashboardBuildable,
         ratingInfoDashboardBuilable: RatingInfoDashboardBuildable,
         screenshotsDashboardBuildable: ScreenshotsDashboardBuildable,
         releaseNoteDashboardBuildable: ReleaseNoteDashboardBuildable
    ) {
        self.topInfoDashboardBuildable = topInfoDashboardBuilable
        self.ratingInfoDashboardBuildable = ratingInfoDashboardBuilable
        self.screenshotsDashboardBuildable = screenshotsDashboardBuildable
        self.releaseNoteDashboardBuildable = releaseNoteDashboardBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTopInfoDashboard() {
        guard topInfoDashboardRouting == nil else { return }
        
        let router = topInfoDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(router.viewControllable)
        
        self.topInfoDashboardRouting = router
        attachChild(router)
    }
    
    // MARK: - RatingInfoDashboard
    func attachRatingInfoDashboard() {
        guard ratingInfoDashboardRouting == nil else { return }
        
        let router = ratingInfoDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(router.viewControllable)

        self.ratingInfoDashboardRouting = router
        attachChild(router)
    }
    
    // MARK: - ScreenshotsDashboard
    func attachScreenshotsDashboard() {
        guard screenshotsDashboardRouting == nil else { return }
        
        let router = screenshotsDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(router.viewControllable)
        
        self.screenshotsDashboardRouting = router
        attachChild(router)
    }
    
    // MARK: - ReleaseNoteDashboard
    func attachReleaseNoteDashboard() {
        guard releaseNoteDashboardRouting == nil else { return }
        
        let router = releaseNoteDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(router.viewControllable)
        
        self.releaseNoteDashboardRouting = router
        attachChild(router)
    }
}

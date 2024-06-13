//
//  ScreenshotsDashboardRouter.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs

protocol ScreenshotsDashboardInteractable: Interactable {
    var router: ScreenshotsDashboardRouting? { get set }
    var listener: ScreenshotsDashboardListener? { get set }
}

protocol ScreenshotsDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ScreenshotsDashboardRouter: ViewableRouter<ScreenshotsDashboardInteractable, ScreenshotsDashboardViewControllable>, ScreenshotsDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ScreenshotsDashboardInteractable, viewController: ScreenshotsDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

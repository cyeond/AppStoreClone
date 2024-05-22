//
//  ScreenshotsDashboardInteractor.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs
import RxSwift

protocol ScreenshotsDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ScreenshotsDashboardPresentable: Presentable {
    var listener: ScreenshotsDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ScreenshotsDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ScreenshotsDashboardInteractor: PresentableInteractor<ScreenshotsDashboardPresentable>, ScreenshotsDashboardInteractable, ScreenshotsDashboardPresentableListener {

    weak var router: ScreenshotsDashboardRouting?
    weak var listener: ScreenshotsDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ScreenshotsDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

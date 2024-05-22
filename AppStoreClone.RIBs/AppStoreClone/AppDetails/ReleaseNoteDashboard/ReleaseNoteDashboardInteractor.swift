//
//  ReleaseNoteDashboardInteractor.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs
import RxSwift

protocol ReleaseNoteDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ReleaseNoteDashboardPresentable: Presentable {
    var listener: ReleaseNoteDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ReleaseNoteDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ReleaseNoteDashboardInteractor: PresentableInteractor<ReleaseNoteDashboardPresentable>, ReleaseNoteDashboardInteractable, ReleaseNoteDashboardPresentableListener {

    weak var router: ReleaseNoteDashboardRouting?
    weak var listener: ReleaseNoteDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ReleaseNoteDashboardPresentable) {
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

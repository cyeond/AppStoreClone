//
//  RatingInfoDashboardInteractor.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import RIBs
import RxSwift

protocol RatingInfoDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RatingInfoDashboardPresentable: Presentable {
    var listener: RatingInfoDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RatingInfoDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RatingInfoDashboardInteractor: PresentableInteractor<RatingInfoDashboardPresentable>, RatingInfoDashboardInteractable, RatingInfoDashboardPresentableListener {

    weak var router: RatingInfoDashboardRouting?
    weak var listener: RatingInfoDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RatingInfoDashboardPresentable) {
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

//
//  TopInfoDashboardInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/18/24.
//

import RIBs
import RxSwift

protocol TopInfoDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TopInfoDashboardPresentable: Presentable {
    var listener: TopInfoDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol TopInfoDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TopInfoDashboardInteractor: PresentableInteractor<TopInfoDashboardPresentable>, TopInfoDashboardInteractable, TopInfoDashboardPresentableListener {

    weak var router: TopInfoDashboardRouting?
    weak var listener: TopInfoDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TopInfoDashboardPresentable) {
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

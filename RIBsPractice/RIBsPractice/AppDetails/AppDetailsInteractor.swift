//
//  AppDetailsInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import RxSwift

protocol AppDetailsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AppDetailsPresentable: Presentable {
    var listener: AppDetailsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AppDetailsListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppDetailsInteractor: PresentableInteractor<AppDetailsPresentable>, AppDetailsInteractable, AppDetailsPresentableListener {

    weak var router: AppDetailsRouting?
    weak var listener: AppDetailsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AppDetailsPresentable) {
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

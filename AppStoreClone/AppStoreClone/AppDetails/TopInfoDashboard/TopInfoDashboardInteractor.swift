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
    
    func update(with info: AppPreviewInfo)
}

protocol TopInfoDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol TopInfoDashboardInteractorDependency {
    var appPreviewInfo: AppPreviewInfo { get }
}

final class TopInfoDashboardInteractor: PresentableInteractor<TopInfoDashboardPresentable>, TopInfoDashboardInteractable, TopInfoDashboardPresentableListener {
    weak var router: TopInfoDashboardRouting?
    weak var listener: TopInfoDashboardListener?
    
    private let dependency: TopInfoDashboardInteractorDependency

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: TopInfoDashboardPresentable, dependency: TopInfoDashboardInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.update(with: dependency.appPreviewInfo)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

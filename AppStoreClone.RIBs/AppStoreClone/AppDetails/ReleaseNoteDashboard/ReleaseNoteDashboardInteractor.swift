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
    
    func update(with info: AppInfo)
}

protocol ReleaseNoteDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol ReleaseNoteDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository { get }
}

final class ReleaseNoteDashboardInteractor: PresentableInteractor<ReleaseNoteDashboardPresentable>, ReleaseNoteDashboardInteractable, ReleaseNoteDashboardPresentableListener {
    weak var router: ReleaseNoteDashboardRouting?
    weak var listener: ReleaseNoteDashboardListener?
    
    private let dependency: ReleaseNoteDashboardInteractorDependency
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ReleaseNoteDashboardPresentable, dependency: ReleaseNoteDashboardInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.appDetailsRepository.appInfoObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] info in
                self?.presenter.update(with: info)
            })
            .disposed(by: disposeBag)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

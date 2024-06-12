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
    
    func update(with sectionModel: CollectionViewSectionModel)
}

protocol ScreenshotsDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol ScreenshotsDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository { get }
}

final class ScreenshotsDashboardInteractor: PresentableInteractor<ScreenshotsDashboardPresentable>, ScreenshotsDashboardInteractable, ScreenshotsDashboardPresentableListener {
    weak var router: ScreenshotsDashboardRouting?
    weak var listener: ScreenshotsDashboardListener?
    
    private let dependency: ScreenshotsDashboardInteractorDependency
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ScreenshotsDashboardPresentable, dependency: ScreenshotsDashboardInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.appDetailsRepository.appInfoObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] info in
                let sectionModel = CollectionViewSectionModel(
                    section: CollectionViewSection(type: .horizontalOne),
                    items: info.screenshotUrls.map { CollectionViewItem(type: .screenshot($0))}
                )
                
                self?.presenter.update(with: sectionModel)
            })
            .disposed(by: disposeBag)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

//
//  TopInfoDashboardInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/18/24.
//

import UIKit
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
    private let disposeBag = DisposeBag()
    private var appstoreUrl: URL?

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
    
    func downloadButtonDidTap() {
        if let url = appstoreUrl, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            API.lookup(dependency.appPreviewInfo.id)
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .observe(on: MainScheduler.instance)
                .subscribe(with: self, onSuccess: { weakSelf, info in
                    guard let urlString = info.results.first?.appstoreUrl, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return }
                    
                    weakSelf.appstoreUrl = url
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                })
                .disposed(by: disposeBag)
        }
    }
    
    func shareButtonDidTap() {
        
    }
}

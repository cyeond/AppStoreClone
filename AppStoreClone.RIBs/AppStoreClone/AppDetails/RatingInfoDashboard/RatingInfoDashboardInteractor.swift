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
    
    func update(with sectionModel: CollectionViewSectionModel)
}

protocol RatingInfoDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol RatingInfoDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository { get }
}

final class RatingInfoDashboardInteractor: PresentableInteractor<RatingInfoDashboardPresentable>, RatingInfoDashboardInteractable, RatingInfoDashboardPresentableListener {

    weak var router: RatingInfoDashboardRouting?
    weak var listener: RatingInfoDashboardListener?
    
    private let dependency: RatingInfoDashboardInteractorDependency
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RatingInfoDashboardPresentable, dependency: RatingInfoDashboardInteractorDependency) {
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
                    section: CollectionViewSection(type: CollectionViewSectionType.horizontalOne),
                    items: [
                        CollectionViewItem(type: .ratingInfo(.userRating(rating: info.averageUserRating, ratingCount: info.userRatingCount))),
                        CollectionViewItem(type: .ratingInfo(.contentRating(info.trackContentRating))),
                        CollectionViewItem(type: .ratingInfo(.developerName(info.developerName))),
                        CollectionViewItem(type: .ratingInfo(.languages(info.languageCodes)))
                    ])
                
                self?.presenter.update(with: sectionModel)
            })
            .disposed(by: disposeBag)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

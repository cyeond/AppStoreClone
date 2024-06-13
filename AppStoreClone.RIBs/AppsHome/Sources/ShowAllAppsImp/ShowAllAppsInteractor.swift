//
//  ShowAllAppsInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import RxSwift
import Entities
import ReuseableViews
import ShowAllApps

protocol ShowAllAppsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ShowAllAppsPresentable: Presentable {
    var listener: ShowAllAppsPresentableListener? { get set }
    
    func update(with sectionModel: CollectionViewSectionModel)
}

final class ShowAllAppsInteractor: PresentableInteractor<ShowAllAppsPresentable>, ShowAllAppsInteractable, ShowAllAppsPresentableListener {
    weak var router: ShowAllAppsRouting?
    weak var listener: ShowAllAppsListener?
    
    let sectionModel: CollectionViewSectionModel

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ShowAllAppsPresentable, sectionModel: CollectionViewSectionModel) {
        self.sectionModel = sectionModel
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.update(with: sectionModel)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBack() {
        listener?.showAllAppsDidTapClose()
    }
    
    func appPreviewActionButtonDidTap(with info: AppPreviewInfo) {
        listener?.showAllAppsDidTapAppPreviewActionButton(with: info)
    }
    
    func appPreviewCellDidTap(with info: AppPreviewInfo) {
        listener?.showAllAppsDidTapAppPreviewCell(with: info)
    }
}

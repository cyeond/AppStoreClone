//
//  SearchHomeInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import RxSwift
import Entities
import ReuseableViews
import Network

protocol SearchHomeRouting: ViewableRouting {
    func attachAppDetails(with info: AppPreviewInfo)
    func detachAppDetails()
}

protocol SearchHomePresentable: Presentable {
    var listener: SearchHomePresentableListener? { get set }
    
    func update(with model: CollectionViewSectionModel)
    func startLoading()
    func stopLoading()
}

public protocol SearchHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchHomeInteractor: PresentableInteractor<SearchHomePresentable>, SearchHomeInteractable, SearchHomePresentableListener {
    weak var router: SearchHomeRouting?
    weak var listener: SearchHomeListener?
    
    private var currentText = ""
    private var currentResults = BehaviorSubject<[AppInfo]>(value: [])
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        currentResults
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] infos in
                let model = CollectionViewSectionModel(section: CollectionViewSection(type: .verticalOne), items: infos.map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) })
                self?.presenter.update(with: model)
            })
            .disposed(by: disposeBag)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func searchButtonDidTap(_ text: String) {
        presenter.startLoading()
        currentResults.onNext([])
        
        API.search(text)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .retry(3)
            .subscribe(with: self, onSuccess: { weakSelf, result in
                weakSelf.currentText = text
                weakSelf.currentResults.onNext(result.results)
            }, onFailure: { _, _ in
            }, onDisposed: { weakSelf in
                weakSelf.presenter.stopLoading()
            })
            .disposed(by: disposeBag)
    }
    
    func cancelButtonDidTap() {
        currentText = ""
        currentResults.onNext([])
    }
    
    func appPreviewCellDidTap(with info: AppPreviewInfo) {
        router?.attachAppDetails(with: info)
    }
    
    // MARK: - From AppDetails
    func appDetailsDidTapClose() {
        router?.detachAppDetails()
    }
}

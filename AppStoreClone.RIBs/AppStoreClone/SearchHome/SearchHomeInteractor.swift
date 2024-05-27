//
//  SearchHomeInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import RxSwift

protocol SearchHomeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchHomePresentable: Presentable {
    var listener: SearchHomePresentableListener? { get set }
    
    func update(with model: CollectionViewSectionModel)
}

protocol SearchHomeListener: AnyObject {
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
        API.search(text)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onSuccess: { weakSelf, result in
                weakSelf.currentText = text
                weakSelf.currentResults.onNext(result.results)
            })
            .disposed(by: disposeBag)
    }
    
    func cancelButtonDidTap() {
        currentText = ""
        currentResults.onNext([])
    }
}

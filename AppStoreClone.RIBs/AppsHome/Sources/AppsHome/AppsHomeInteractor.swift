//
//  AppsHomeInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import RxSwift
import Entities
import ReuseableViews
import Network

protocol AppsHomeRouting: ViewableRouting {
    func attachShowAllApps(with sectionModel: CollectionViewSectionModel)
    func detachShowAllApps()
    
    func attachAppDetails(with info: AppPreviewInfo)
    func detachAppDetails()
}

protocol AppsHomePresentable: Presentable {
    var listener: AppsHomePresentableListener? { get set }
    
    func update(with viewModel: [CollectionViewSectionModel])
}

public protocol AppsHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppsHomeInteractor: PresentableInteractor<AppsHomePresentable>, AppsHomeInteractable, AppsHomePresentableListener {
    weak var router: AppsHomeRouting?
    weak var listener: AppsHomeListener?
    
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AppsHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        Single.zip(
            API.lookup(AppsHomeInteractor.editorPicked),
            API.search("여행"),
            API.search("엔터테인먼트")
        )
        .subscribe(onSuccess: { [weak self] result1, result2, result3 in
            let items1 = result1.results.map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) }
            let viewModel1 = CollectionViewSectionModel(
                section: CollectionViewSection(type: .groupedThree(title: AppsHomeInteractor.sectionData[0].title, subtitle: AppsHomeInteractor.sectionData[0].subtitle)),
                items: items1)
            
            let items2 = result2.results.prefix(11).map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) }
            let viewModel2 = CollectionViewSectionModel(
                section: CollectionViewSection(type: .groupedThree(title: AppsHomeInteractor.sectionData[1].title, subtitle: AppsHomeInteractor.sectionData[1].subtitle)),
                items: items2)
            
            let items3 = result3.results.prefix(11).map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) }
            let viewModel3 = CollectionViewSectionModel(
                section: CollectionViewSection(type: .groupedThree(title: AppsHomeInteractor.sectionData[2].title, subtitle: AppsHomeInteractor.sectionData[2].subtitle)),
                items: items3)
            
            self?.presenter.update(with: [viewModel1, viewModel2, viewModel3])
        })
        .disposed(by: disposeBag)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - From AppsHomeViewController
    func seeAllButtonDidTap(with sectionModel: CollectionViewSectionModel) {
        router?.attachShowAllApps(with: sectionModel)
    }
    
    func appPreviewActionButtonDidTap(with info: AppPreviewInfo) {
        
    }
    
    func appPreviewCellDidTap(with info: AppPreviewInfo) {
        router?.attachAppDetails(with: info)
    }
    
    // MARK: - From ShowAllApps Riblet
    func showAllAppsDidTapClose() {
        router?.detachShowAllApps()
    }
    
    func showAllAppsDidTapAppPreviewActionButton(with info: AppPreviewInfo) {
        
    }
    
    func showAllAppsDidTapAppPreviewCell(with info: AppPreviewInfo) {
        router?.attachAppDetails(with: info)
    }
    
    // MARK: - From AppDetails
    func appDetailsDidTapClose() {
        router?.detachAppDetails()
    }
    
}

extension AppsHomeInteractor {
    struct AppsHomeSectionData {
        let title: String
        let subtitle: String
    }
    
    static let sectionData: [AppsHomeSectionData] = [
        AppsHomeSectionData(title: "iPhone 필수 앱", subtitle: "에디터가 직접 고른 추천 앱으로 시작하세요"),
        AppsHomeSectionData(title: "설레고 가벼운 여행 준비", subtitle: ""),
        AppsHomeSectionData(title: "볼까, 들을까, 읽을까?", subtitle: "최고의 엔터테인먼트 앱을 모았습니다")
    ]
    
    static let editorPicked = "839333328,1554807824,1464496236,981110422,304608425,431589174,311867728,1018769995"
}

//
//  AppsHomeInteractor.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import RxSwift

protocol AppsHomeRouting: ViewableRouting {
    func attachShowAllApps(with sectionModel: CollectionViewSectionModel)
    func detachShowAllApps()
}

protocol AppsHomePresentable: Presentable {
    var listener: AppsHomePresentableListener? { get set }
    
    func update(with viewModel: [CollectionViewSectionModel])
}

protocol AppsHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppsHomeInteractor: PresentableInteractor<AppsHomePresentable>, AppsHomeInteractable, AppsHomePresentableListener {
    weak var router: AppsHomeRouting?
    weak var listener: AppsHomeListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AppsHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let viewModel = AppsHomeInteractor.dummyData
        
        presenter.update(with: viewModel)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - AppsHomeViewController
    func seeAllButtonDidTap(with sectionModel: CollectionViewSectionModel) {
        router?.attachShowAllApps(with: sectionModel)
    }
    
    func appPreviewActionButtonDidTap(with info: AppPreviewInfo) {
        
    }
    
    func appPreviewCellDidTap(with info: AppPreviewInfo) {
        
    }
    
    // MARK: - ShowAllApps
    func showAllAppsDidTapClose() {
        router?.detachShowAllApps()
    }
    
    func showAllAppsDidTapAppPreviewActionButton(with info: AppPreviewInfo) {
        
    }
    
    func showAllAppsDidTapAppPreviewCell(with info: AppPreviewInfo) {
        
    }
    
}

extension AppsHomeInteractor {
    static let dummyData = [
        CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupThree(title: "iPhone 필수 앱", subtitle: "에디터가 직접 고른 추천 앱으로 시작하세요")),
            items: [
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "토스", subtitle:  "금융이 쉬워진다"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "네이버페이", subtitle: "지갑 없이 매장에서 결제"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "카카오페이", subtitle: "마음 놓고 금융하다"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "카카오 T - 택시, 대리, 주차, 바이크, 항공, 퀵", subtitle: "모든 이동을 위한 모빌리티 서비스"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "카카오맵 - 대한민국 No.1 지도앱", subtitle: "좋은 곳으로 이끌어 줄 지도"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "티맵 - 대중교통, 대리운전, 주차, 렌터카, 공항버스", subtitle: "당신의 이동능력, 티맵"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "NAVER Map, Navigation", subtitle: "내비게이션"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "당근", subtitle: "당신 근처의 지역 생활 커뮤니티"))),
            ]),
        CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupThree(title: "에디터의 선택 시리즈", subtitle: "")),
            items: [
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "토스", subtitle: "금융이 쉬워진다"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "트래블월렛 - TravelPay", subtitle: "페이에 세계를 담다"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "29CM", subtitle: "감도 깊은 취향 셀렉트샵"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "Goodnotes 6", subtitle: "새롭게 태어난 노트."))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "Forest - 꿈을 향한 집중 타이머 & 스톱워치", subtitle: "스마트폰 중독에서 벗어나기"))),
            ]),
        CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupThree(title: "지금 주목해야 할 앱", subtitle: "새로 나온 앱과 업데이트")),
            items: [
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "타입플릭 TIMEFLIK 워치페이스", subtitle: "커스텀 워치페이스 & 스트랩"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "Goodnotes 6", subtitle: "새롭게 태어난 노트."))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "PhotoWidget : Simple\n(포토위젯)", subtitle: "상상할 수 있는 모든 위젯: 테마, 배경화면, 아이콘"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "EPIK 에픽 - AI 사진 & 영상 편집", subtitle: "필터, 이펙트, 보정, 메이크업, 템플릿, AI"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(title: "네이버웍스 - NAVER WORKS", subtitle: "네이버가 만든 업무용 협업도구"))),
            ]),
    ]
}

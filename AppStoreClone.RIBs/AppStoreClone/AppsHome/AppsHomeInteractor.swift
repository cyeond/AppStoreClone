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
    
    func attachAppDetails(with info: AppPreviewInfo)
    func detachAppDetails()
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
    static let dummyData = [
        CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupThree(title: "iPhone 필수 앱", subtitle: "에디터가 직접 고른 추천 앱으로 시작하세요")),
            items: [
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "839333328", title: "토스", subtitle:  "금융이 쉬워진다", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/0a/25/6e/0a256ea5-94e5-51fa-59d4-cb814ca5de7b/AppIcon-0-0-1x_U007ephone-0-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1554807824", title: "네이버페이", subtitle: "지갑 없이 매장에서 결제", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/27/bf/32/27bf32f8-cc10-59b7-0864-eef044818a30/AppIcon-0-0-1x_U007emarketing-0-7-0-sRGB-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1464496236", title: "카카오페이", subtitle: "마음 놓고 금융하다", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/83/41/b4/8341b42c-1953-5d9f-a5c4-3f82368c9fee/AppIcon-0-0-1x_U007emarketing-0-10-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "981110422", title: "카카오 T - 택시, 대리, 주차, 바이크, 항공, 퀵", subtitle: "모든 이동을 위한 모빌리티 서비스", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/d9/a8/54/d9a854b9-e923-899c-457b-1a6dc8dce53b/AppIcon-0-0-1x_U007emarketing-0-6-0-sRGB-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "304608425", title: "카카오맵 - 대한민국 No.1 지도앱", subtitle: "좋은 곳으로 이끌어 줄 지도", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/23/fc/70/23fc705b-b89b-681a-c3c1-b6b56ca783ed/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "431589174", title: "티맵 - 대중교통, 대리운전, 주차, 렌터카, 공항버스", subtitle: "당신의 이동능력, 티맵", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/5d/6e/5f/5d6e5f0d-7243-f383-be06-18b5da8a008a/AppIcon-0-1x_U007emarketing-0-7-0-sRGB-85-220-0.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "311867728", title: "NAVER Map, Navigation", subtitle: "내비게이션", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/74/d5/d4/74d5d42f-71f9-d3a6-11a9-1acd36e18570/AppIcon-0-0-1x_U007epad-0-0-sRGB-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1018769995", title: "당근", subtitle: "당신 근처의 지역 생활 커뮤니티", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/60/b3/4c/60b34c93-8d4a-1749-9c34-01dafaf61d71/AppIcon-0-0-1x_U007ephone-0-85-220.png/100x100bb.jpg"))),
            ]),
        CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupThree(title: "에디터의 선택 시리즈", subtitle: "")),
            items: [
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "839333328", title: "토스", subtitle: "금융이 쉬워진다", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/0a/25/6e/0a256ea5-94e5-51fa-59d4-cb814ca5de7b/AppIcon-0-0-1x_U007ephone-0-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1460769945", title: "트래블월렛 - TravelPay", subtitle: "페이에 세계를 담다", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/29/33/ce/2933ce77-d830-8b89-c94b-714e27c94ca4/AppIcon-0-0-1x_U007emarketing-0-6-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "789634744", title: "29CM", subtitle: "감도 깊은 취향 셀렉트샵", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/ab/ae/80/abae8039-6752-5d05-c925-6d21442d5202/AppIcon-0-0-1x_U007ephone-0-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1444383602", title: "Goodnotes 6", subtitle: "새롭게 태어난 노트.", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/ef/34/0e/ef340e63-0a0e-1671-0e23-c8f67bd8c3a9/AppIcon-0-0-1x_U007epad-0-0-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "866450515", title: "Forest - 꿈을 향한 집중 타이머 & 스톱워치", subtitle: "스마트폰 중독에서 벗어나기", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/07/73/c9/0773c931-9336-10fe-7d72-b648e9b48e39/AppIcon-0-0-1x_U007epad-0-0-0-85-220.png/100x100bb.jpg"))),
            ]),
        CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupThree(title: "지금 주목해야 할 앱", subtitle: "새로 나온 앱과 업데이트")),
            items: [
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1097434319", title: "타임플릭 TIMEFLIK 워치페이스", subtitle: "커스텀 워치페이스 & 스트랩", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/b8/63/b8/b863b8a0-7849-f4fa-0e32-d69be7b7c072/AppIcon-0-0-1x_U007emarketing-0-10-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1444383602", title: "Goodnotes 6", subtitle: "새롭게 태어난 노트.", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/ef/34/0e/ef340e63-0a0e-1671-0e23-c8f67bd8c3a9/AppIcon-0-0-1x_U007epad-0-0-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1530149106", title: "PhotoWidget : Simple\n(포토위젯)", subtitle: "상상할 수 있는 모든 위젯: 테마, 배경화면, 아이콘", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/f5/d7/0b/f5d70b71-b58a-4228-6bca-145d9a51bf1f/AppIcon-0-0-1x_U007epad-0-0-0-sRGB-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "1577705074", title: "EPIK 에픽 - AI 사진 & 영상 편집", subtitle: "필터, 이펙트, 보정, 메이크업, 템플릿, AI", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/00/77/b0/0077b03e-dff4-c66c-cf9e-022603ee8979/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/100x100bb.jpg"))),
                CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: "393499958", title: "네이버 - NAVER", subtitle: "검색과 콘텐츠, 쇼핑, 내도구", iconUri: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/61/10/8b/61108bc2-503e-ade1-4416-d4baeeaadb5a/AppIcon-0-0-1x_U007emarketing-0-7-0-sRGB-0-85-220.png/100x100bb.jpg"))),
            ]),
    ]
}

//
//  AppsHomeViewModel.swift
//  AppStoreClone
//
//  Created by YD on 6/7/24.
//

import Foundation
import RxSwift
import RxCocoa

final class AppsHomeViewModel {
    struct Input {
        let loadTrigger: Observable<Void>
        let appPreviewCellDidTap: Observable<IndexPath>
    }
    
    struct Output {
        let items: Driver<[CollectionViewSectionModel]>
        let isLoading: Driver<Bool>
        let error: Driver<Error>
    }
    
    private let itemsRelay = BehaviorRelay<[CollectionViewSectionModel]>(value: [])
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<Error>()
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.loadTrigger
            .flatMapLatest { [weak self] _ -> Single<(APISearchResult, APISearchResult, APISearchResult)> in
                self?.isLoadingRelay.accept(true)
                return Single.zip(
                    API.lookup(AppsHomeViewModel.editorPicked),
                    API.search("여행"),
                    API.search("엔터테인먼트")
                )
            }
            .subscribe(onNext: { [weak self] editorPickedResult, travelResult, entertainmentResult in
                if let sectionModels = self?.createSectionModelsWithResults(editorPickedResult, travelResult, entertainmentResult) {
                    self?.itemsRelay.accept(sectionModels)
                }
            }, onCompleted: { [weak self] in
                self?.isLoadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
        
        return Output(
            items: itemsRelay.asDriver(),
            isLoading: isLoadingRelay.asDriver(),
            error: errorRelay.asDriver(onErrorDriveWith: Driver.empty())
        )
    }
}

extension AppsHomeViewModel {
    private func createSectionModelsWithResults(_ editorPickedResult: APISearchResult, _ travelResult: APISearchResult, _ entertainmentResult: APISearchResult) -> [CollectionViewSectionModel] {
        let items1 = editorPickedResult.results.map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) }
        let viewModel1 = CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupedThree(title: AppsHomeViewModel.sectionData[0].title, subtitle: AppsHomeViewModel.sectionData[0].subtitle)),
            items: items1)
        
        let items2 = travelResult.results.prefix(11).map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) }
        let viewModel2 = CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupedThree(title: AppsHomeViewModel.sectionData[1].title, subtitle: AppsHomeViewModel.sectionData[1].subtitle)),
            items: items2)
        
        let items3 = entertainmentResult.results.prefix(11).map { CollectionViewItem(type: .appPreviewBasic(AppPreviewInfo(id: String($0.id), title: $0.title, developerName: $0.developerName, iconUri: $0.iconUrl))) }
        let viewModel3 = CollectionViewSectionModel(
            section: CollectionViewSection(type: .groupedThree(title: AppsHomeViewModel.sectionData[2].title, subtitle: AppsHomeViewModel.sectionData[2].subtitle)),
            items: items3)
        
        return [viewModel1, viewModel2, viewModel3]
    }
}

extension AppsHomeViewModel {
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

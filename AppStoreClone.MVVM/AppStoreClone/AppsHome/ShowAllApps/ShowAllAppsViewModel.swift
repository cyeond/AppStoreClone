//
//  ShowAllAppsViewModel.swift
//  AppStoreClone
//
//  Created by YD on 6/7/24.
//

import RxSwift
import RxCocoa

final class ShowAllAppsViewModel {
    struct Input {
    }
    
    struct Output {
        let item: Driver<CollectionViewSectionModel>
    }
    
    init(sectionModel: CollectionViewSectionModel) {
        self.itemRelay = BehaviorRelay<CollectionViewSectionModel>(value: sectionModel)
    }
    
    private let itemRelay: BehaviorRelay<CollectionViewSectionModel>
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output(
            item: itemRelay.asDriver()
        )
    }
}

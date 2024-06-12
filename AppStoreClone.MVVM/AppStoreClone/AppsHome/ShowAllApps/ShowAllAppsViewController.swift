//
//  ShowAllAppsViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RxSwift
import UIKit

final class ShowAllAppsViewController: UIViewController {
    var viewModel: ShowAllAppsViewModel?
    
    private var sectionModel: CollectionViewSectionModel?
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .background
        collectionView.register(AppPreviewBasicCell.self, forCellWithReuseIdentifier: AppPreviewBasicCell.identifier)
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCollectionViewDataSource()
        bindViewModel()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.backgroundColor = .background
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        let input = ShowAllAppsViewModel.Input()
        let output = viewModel?.transform(input: input)
        
        output?.item
            .drive(with: self) { weakSelf, item in
                weakSelf.update(with: item)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - CollectionView Layout
extension ShowAllAppsViewController {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, envrionment in
            return self?.sectionModel?.layoutSection()
        }, configuration: config)
    }
}

// MARK: - CollectionView DataSource
extension ShowAllAppsViewController {
    private func setupCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, item in
            switch item.type {
            case .appPreviewBasic(let info):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppPreviewBasicCell.identifier, for: indexPath) as? AppPreviewBasicCell else { return UICollectionViewCell() }
                cell.update(with: AppPreviewBasicViewModel(previewInfo: info, tapHandler: {
//                    appPreviewActionButtonDidTap
                }))
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    private func update(with sectionModel: CollectionViewSectionModel) {
        switch sectionModel.section.type {
        case .groupedThree(title: let title, subtitle: _):
            self.title = title
        default:
            return
        }
        
        let newSection = CollectionViewSection(type: .verticalOne)
        self.sectionModel = CollectionViewSectionModel(section: newSection, items: sectionModel.items)
        
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        snapshot.appendSections([newSection])
        snapshot.appendItems(sectionModel.items, toSection: newSection)
        collectionViewDataSource?.apply(snapshot)
    }
}

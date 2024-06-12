//
//  AppsHomeViewController.swift
//  AppStoreClone
//
//  Created by YD on 6/7/24.
//

import RxSwift
import UIKit

final class AppsHomeViewController: UIViewController {
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var sectionModel: [CollectionViewSectionModel] = []
    
    private let seeAllButtonDidTap = PublishSubject<Int>()
    private let viewModel = AppsHomeViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .background
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(AppPreviewBasicCell.self, forCellWithReuseIdentifier: AppPreviewBasicCell.identifier)
        collectionView.register(AppPreviewBasicHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppPreviewBasicHeaderView.identifier)
        collectionView.contentInset = .init(top: 10.0, left: 0, bottom: 10.0, right: 0)
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.stopAnimating()
        return activity
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCollectionViewDataSource()
        bindViewModel()
    }
    
    private func setupViews() {
        title = "앱"
        tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up.fill"), selectedImage: UIImage(systemName: "square.stack.3d.up.fill"))
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        view.backgroundColor = .background
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func bindViewModel() {
        let loadTrigger = Observable.just(())
        let appPreviewCellDidTap = collectionView.rx.itemSelected.asObservable()
        
        let input = AppsHomeViewModel.Input(
            loadTrigger: loadTrigger,
            appPreviewCellDidTap: appPreviewCellDidTap,
            seeAllButtonDidTap: seeAllButtonDidTap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(with: self) { weakSelf, items in
                weakSelf.update(with: items)
            }
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.pushViewController
            .emit(with: self) { weakSelf, vc in
                weakSelf.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.error
            .emit(onNext: { error in
                
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - CollectionView Layout
extension AppsHomeViewController {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.0
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            return self?.sectionModel[safe: sectionIndex]?.layoutSection()
        }, configuration: config)
    }
}

//MARK: - CollectionView DataSource
extension AppsHomeViewController {
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
        
        collectionViewDataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppPreviewBasicHeaderView.identifier, for: indexPath) as? AppPreviewBasicHeaderView
            if let type = self?.sectionModel[safe: indexPath.section]?.section.type {
                switch type {
                case .groupedThree(title: let title, subtitle: let subtitle):
                    header?.update(with: AppPreviewBasicHeaderViewModel(title: title, subtitle: subtitle, tapHandler: {
                        self?.seeAllButtonDidTap.onNext(indexPath.section)
                    }))
                default:
                    return nil
                }
            }
            return header
        }
    }
    
    private func update(with sectionModel: [CollectionViewSectionModel]) {
        self.sectionModel = sectionModel
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        
        sectionModel.forEach { model in
            snapshot.appendSections([model.section])
            snapshot.appendItems(model.items, toSection: model.section)
        }
        
        collectionViewDataSource?.apply(snapshot)
    }
}


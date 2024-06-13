//
//  ScreenshotsDashboardViewController.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs
import RxSwift
import UIKit
import ReuseableViews

protocol ScreenshotsDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ScreenshotsDashboardViewController: UIViewController, ScreenshotsDashboardPresentable, ScreenshotsDashboardViewControllable {
    weak var listener: ScreenshotsDashboardPresentableListener?
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var collectionViewSectionModel: CollectionViewSectionModel?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.identifier)
        collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.identifier)
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
        return collectionView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupCollectionViewDataSource()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupCollectionViewDataSource()
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            collectionView.heightAnchor.constraint(equalToConstant: TitleHeaderView.height+ScreenshotCell.height)
        ])
    }
}

// MARK: - CollectionView Layout
extension ScreenshotsDashboardViewController {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(TitleHeaderView.height))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = self?.collectionViewSectionModel?.layoutSection()
            section?.orthogonalScrollingBehavior = .groupPaging
            section?.boundarySupplementaryItems = [header]
            return section
        }, configuration: config)
    }
}

// MARK: - CollectionView DataSource
extension ScreenshotsDashboardViewController {
    private func setupCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.identifier, for: indexPath) as? ScreenshotCell else { return UICollectionViewCell() }
            switch itemIdentifier.type {
            case .screenshot(let uri):
                cell.update(uri: uri)
            default:
                break
            }
            return cell
        })
        
        collectionViewDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.identifier, for: indexPath) as? TitleHeaderView
            headerView?.update(title: "미리 보기")
            return headerView
        }
    }
    
    func update(with sectionModel: CollectionViewSectionModel) {
        self.collectionViewSectionModel = sectionModel
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        snapshot.appendSections([sectionModel.section])
        snapshot.appendItems(sectionModel.items, toSection: sectionModel.section)
        collectionViewDataSource?.apply(snapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension ScreenshotsDashboardViewController: UICollectionViewDelegate {
    
}

//
//  RatingInfoDashboardViewController.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import RIBs
import RxSwift
import UIKit
import ReuseableViews

protocol RatingInfoDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RatingInfoDashboardViewController: UIViewController, RatingInfoDashboardPresentable, RatingInfoDashboardViewControllable {
    weak var listener: RatingInfoDashboardPresentableListener?
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var collectionViewSectionModel: CollectionViewSectionModel?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RatingInfoCell.self, forCellWithReuseIdentifier: RatingInfoCell.identifier)
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
            collectionView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
}

// MARK: - CollectionView Layout
extension RatingInfoDashboardViewController {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            self?.collectionViewSectionModel?.layoutSection()
        }, configuration: config)
    }
}

// MARK: - CollectionView DataSource
extension RatingInfoDashboardViewController {
    private func setupCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RatingInfoCell.identifier, for: indexPath) as? RatingInfoCell else { return UICollectionViewCell() }
            switch itemIdentifier.type {
            case .ratingInfo(let type):
                cell.update(type: type)
            default:
                break
            }
            return cell
        })
        
        let section = CollectionViewSection(type: .horizontalOne)
        let items = [
            CollectionViewItem(type: .ratingInfo(.userRating(rating: 0, ratingCount: 0))),
            CollectionViewItem(type: .ratingInfo(.contentRating(" "))),
            CollectionViewItem(type: .ratingInfo(.developerName(" "))),
            CollectionViewItem(type: .ratingInfo(.languages([" "])))
        ]
        let initialModel = CollectionViewSectionModel(section: section, items: items)
        update(with: initialModel)
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
extension RatingInfoDashboardViewController: UICollectionViewDelegate {
    
}

//
//  ShowAllAppsViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import RxSwift
import UIKit

protocol ShowAllAppsPresentableListener: AnyObject {
    func didTapBack()
    func appPreviewActionButtonDidTap(with info: AppPreviewInfo)
    func appPreviewCellDidTap(with info: AppPreviewInfo)
}

final class ShowAllAppsViewController: UIViewController, ShowAllAppsPresentable, ShowAllAppsViewControllable {
    weak var listener: ShowAllAppsPresentableListener?
    
    private var sectionModel: CollectionViewSectionModel?
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(AppPreviewBasicCell.self, forCellWithReuseIdentifier: AppPreviewBasicCell.identifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        setupNavigationItem(with: .back, target: self, action: #selector(didTapBack))
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc
    private func didTapBack() {
        listener?.didTapBack()
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
                    self?.listener?.appPreviewActionButtonDidTap(with: info)
                }))
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    func update(with sectionModel: CollectionViewSectionModel) {
        switch sectionModel.section.type {
        case .groupThree(title: let title, subtitle: _):
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

// MARK: - CollectionView Delegate
extension ShowAllAppsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let info = sectionModel?.items[safe: indexPath.row] {
            switch info.type {
            case .appPreviewBasic(let info):
                listener?.appPreviewCellDidTap(with: info)
            default:
                break
            }
        }
    }
}

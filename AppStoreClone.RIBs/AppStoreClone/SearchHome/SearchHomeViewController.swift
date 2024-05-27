//
//  SearchHomeViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import RxSwift
import UIKit

protocol SearchHomePresentableListener: AnyObject {
    func searchButtonDidTap(_ text: String)
    func cancelButtonDidTap()
    func appPreviewCellDidTap(with info: AppPreviewInfo)
}

final class SearchHomeViewController: UIViewController, SearchHomePresentable, SearchHomeViewControllable {
    weak var listener: SearchHomePresentableListener?
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var collectionViewSectionModel: CollectionViewSectionModel?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .background
        collectionView.delegate = self
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController()
//        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setupViews() {
        title = "검색"
        tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        view.backgroundColor = .background
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UISearchBarDelegate
extension SearchHomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 0 else { return }
        
        listener?.searchButtonDidTap(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listener?.cancelButtonDidTap()
    }
}

// MARK: - CollectionView Layout
extension SearchHomeViewController {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            return self?.collectionViewSectionModel?.layoutSection()
        }, configuration: config)
    }
}

// MARK: - CollectionView DataSource
extension SearchHomeViewController {
    private func setupCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item.type {
            case .appPreviewBasic(let info):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppPreviewBasicCell.identifier, for: indexPath) as? AppPreviewBasicCell else { return UICollectionViewCell() }
                cell.update(with: AppPreviewBasicViewModel(previewInfo: info, tapHandler: {}))
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    func update(with model: CollectionViewSectionModel) {
        self.collectionViewSectionModel = model
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        snapshot.appendSections([model.section])
        snapshot.appendItems(model.items, toSection: model.section)
        collectionViewDataSource?.apply(snapshot)
    }
}

// MARK: - CollectionView Delegate
extension SearchHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let info = collectionViewSectionModel?.items[safe: indexPath.row] {
            switch info.type {
            case .appPreviewBasic(let info):
                listener?.appPreviewCellDidTap(with: info)
            default:
                break
            }
        }
    }
}

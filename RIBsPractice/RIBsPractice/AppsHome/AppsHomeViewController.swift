//
//  AppsHomeViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import RxSwift
import UIKit

protocol AppsHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppsHomeViewController: UIViewController, AppsHomePresentable, AppsHomeViewControllable {
    weak var listener: AppsHomePresentableListener?
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, String>?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(AppsHomeCollectionViewCell.self, forCellWithReuseIdentifier: AppsHomeCollectionViewCell.identifier)
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
    
    private func setupViews() {
        title = "앱"
        tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up.fill"), selectedImage: UIImage(systemName: "square.stack.3d.up.fill"))
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - CollectionView Layout
extension AppsHomeViewController {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            return self?.createLayoutSection()
        }, configuration: config)
    }
    
    private func createLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(310.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10.0, leading: 0, bottom: 10.0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

//MARK: - CollectionView DataSource
extension AppsHomeViewController {
    private func setupCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, book in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHomeCollectionViewCell.identifier, for: indexPath) as? AppsHomeCollectionViewCell else { return UICollectionViewCell() }
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["1"])
        snapshot.appendItems(["1", "2", "3", "4"], toSection: "1")
        collectionViewDataSource?.apply(snapshot)
    }
}

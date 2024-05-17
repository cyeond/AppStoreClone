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
}

final class ShowAllAppsViewController: UIViewController, ShowAllAppsPresentable, ShowAllAppsViewControllable {
    weak var listener: ShowAllAppsPresentableListener?
    
    private var sectionModel: CollectionViewSectionModel?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
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
    
    func update(with sectionModel: CollectionViewSectionModel) {
        self.sectionModel = sectionModel

        switch sectionModel.section.type {
        case .groupThree(title: let title, subtitle: _):
            self.title = title
        default:
            return
        }
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

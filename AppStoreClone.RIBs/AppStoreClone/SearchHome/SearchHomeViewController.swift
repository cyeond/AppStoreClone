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
}

final class SearchHomeViewController: UIViewController, SearchHomePresentable, SearchHomeViewControllable {
    weak var listener: SearchHomePresentableListener?
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setupViews() {
        title = "검색"
        tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        view.backgroundColor = .background
    }
}

extension SearchHomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 0 else { return }
        
        listener?.searchButtonDidTap(text)
    }
}

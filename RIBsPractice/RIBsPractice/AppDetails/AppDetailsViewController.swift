//
//  AppDetailsViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import RIBs
import RxSwift
import UIKit

protocol AppDetailsPresentableListener: AnyObject {
    func didTapBack()
}

final class AppDetailsViewController: UIViewController, AppDetailsPresentable, AppDetailsViewControllable {
    weak var listener: AppDetailsPresentableListener?
    
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
        
        setupNavigationItem(with: .back, target: self, action: #selector(didTapBack))
    }
    
    @objc
    private func didTapBack() {
        listener?.didTapBack()
    }
}

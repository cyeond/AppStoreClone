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
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ShowAllAppsViewController: UIViewController, ShowAllAppsPresentable, ShowAllAppsViewControllable {
    weak var listener: ShowAllAppsPresentableListener?
    
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
        
    }
    
    func update(with sectionModel: CollectionViewSectionModel) {
        switch sectionModel.section.type {
        case .groupThree(title: let title, subtitle: _):
            self.title = title
        }
    }
}

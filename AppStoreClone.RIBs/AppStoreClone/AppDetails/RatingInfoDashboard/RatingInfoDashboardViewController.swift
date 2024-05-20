//
//  RatingInfoDashboardViewController.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import RIBs
import RxSwift
import UIKit

protocol RatingInfoDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RatingInfoDashboardViewController: UIViewController, RatingInfoDashboardPresentable, RatingInfoDashboardViewControllable {
    weak var listener: RatingInfoDashboardPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        
    }
}

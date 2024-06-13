//
//  UIViewController+Utils.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import UIKit

public enum DismissButtonType {
    case back, close
    
    var iconSystemName: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
}

public extension UIViewController {
    func setupNavigationItem(with buttonType: DismissButtonType, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: buttonType.iconSystemName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 18.0, weight: .semibold)),
            style: .plain,
            target: target,
            action: action
        )
    }
}

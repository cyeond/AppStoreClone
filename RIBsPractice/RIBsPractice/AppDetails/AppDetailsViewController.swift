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
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppDetailsViewController: UIViewController, AppDetailsPresentable, AppDetailsViewControllable {

    weak var listener: AppDetailsPresentableListener?
}

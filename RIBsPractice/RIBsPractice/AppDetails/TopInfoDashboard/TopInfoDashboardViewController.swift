//
//  TopInfoDashboardViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/18/24.
//

import RIBs
import RxSwift
import UIKit

protocol TopInfoDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TopInfoDashboardViewController: UIViewController, TopInfoDashboardPresentable, TopInfoDashboardViewControllable {

    weak var listener: TopInfoDashboardPresentableListener?
}

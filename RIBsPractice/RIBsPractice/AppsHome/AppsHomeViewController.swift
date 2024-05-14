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
}

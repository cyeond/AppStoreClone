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
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchHomeViewController: UIViewController, SearchHomePresentable, SearchHomeViewControllable {

    weak var listener: SearchHomePresentableListener?
}

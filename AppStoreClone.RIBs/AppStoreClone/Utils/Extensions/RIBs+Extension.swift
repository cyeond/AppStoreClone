//
//  RIBs+Utils.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import UIKit
import RIBs

final class NavigationControllerable: ViewControllable {
  
  var uiviewController: UIViewController { self.navigationController }
  let navigationController: UINavigationController
  
  public init(root: ViewControllable) {
    let navigation = UINavigationController(rootViewController: root.uiviewController)
    navigation.navigationBar.isTranslucent = false
    navigation.navigationBar.backgroundColor = .background
    navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance
    
    self.navigationController = navigation
  }
}

extension ViewControllable {
  func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
    self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
  }
  
  func dismiss(completion: (() -> Void)?) {
    self.uiviewController.dismiss(animated: true, completion: completion)
  }
  
  func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.pushViewController(viewControllable.uiviewController, animated: animated)
    } else {
      self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
    }
  }
  
  func popViewController(animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.popViewController(animated: animated)
    } else {
      self.uiviewController.navigationController?.popViewController(animated: animated)
    }
  }
  
  func popToRoot(animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.popToRootViewController(animated: animated)
    } else {
      self.uiviewController.navigationController?.popToRootViewController(animated: animated)
    }
  }
  
  func setViewControllers(_ viewControllerables: [ViewControllable]) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
    } else {
      self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
    }
  }
}


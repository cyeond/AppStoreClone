//
//  File.swift
//  
//
//  Created by YD on 6/14/24.
//

import UIKit

extension UIApplication: UIApplicationProtocol {}

public protocol UIApplicationProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?)
}

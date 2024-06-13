//
//  File.swift
//  
//
//  Created by YD on 6/13/24.
//

import Foundation
import RIBs
import Entities

public protocol AppDetailsBuildable: Buildable {
    func build(withListener listener: AppDetailsListener, info: AppPreviewInfo) -> ViewableRouting
}

public protocol AppDetailsListener: AnyObject {
    func appDetailsDidTapClose()
}

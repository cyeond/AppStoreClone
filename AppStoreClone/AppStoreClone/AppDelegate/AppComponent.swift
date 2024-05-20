//
//  AppComponent.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import Foundation
import RIBs

final class AppComponent: Component<EmptyComponent>, AppRootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}

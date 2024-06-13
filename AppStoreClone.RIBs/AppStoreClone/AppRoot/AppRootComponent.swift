//
//  AppRootComponent.swift
//  AppStoreClone
//
//  Created by YD on 6/13/24.
//

import Foundation
import AppsHome
import AppDetails
import AppDetailsImp
import ShowAllApps
import ShowAllAppsImp
import RIBs

final class AppRootComponent: Component<AppRootDependency>, AppsHomeDependency, SearchHomeDependency, ShowAllAppsDependency, AppDetailsDependency {
    lazy var appDetailsBuildable: AppDetailsBuildable = {
        return AppDetailsBuilder(dependency: self)
    }()
    lazy var showAllAppsBuildable: ShowAllAppsBuildable = {
        return ShowAllAppsBuilder(dependency: self)
    }()
}

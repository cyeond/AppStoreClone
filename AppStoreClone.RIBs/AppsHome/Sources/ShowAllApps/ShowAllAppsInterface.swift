//
//  ShowAllAppsInterface.swift
//
//
//  Created by YD on 6/13/24.
//

import Foundation
import RIBs
import Entities
import ReuseableViews

public protocol ShowAllAppsBuildable: Buildable {
    func build(withListener listener: ShowAllAppsListener, sectionModel: CollectionViewSectionModel) -> ViewableRouting
}

public protocol ShowAllAppsListener: AnyObject {
    func showAllAppsDidTapClose()
    func showAllAppsDidTapAppPreviewActionButton(with info: AppPreviewInfo)
    func showAllAppsDidTapAppPreviewCell(with info: AppPreviewInfo)
}

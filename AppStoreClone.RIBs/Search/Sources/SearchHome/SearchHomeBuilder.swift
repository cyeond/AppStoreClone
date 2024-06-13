//
//  SearchHomeBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs
import AppDetails

public protocol SearchHomeDependency: Dependency {
    var appDetailsBuildable: AppDetailsBuildable { get }
}

final class SearchHomeComponent: Component<SearchHomeDependency> {
    var appDetailsBuildable: AppDetailsBuildable { dependency.appDetailsBuildable }
}

// MARK: - Builder

public protocol SearchHomeBuildable: Buildable {
    func build(withListener listener: SearchHomeListener) -> ViewableRouting
}

public final class SearchHomeBuilder: Builder<SearchHomeDependency>, SearchHomeBuildable {

    public override init(dependency: SearchHomeDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: SearchHomeListener) -> ViewableRouting {
        let component = SearchHomeComponent(dependency: dependency)
        let viewController = SearchHomeViewController()
        let interactor = SearchHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        return SearchHomeRouter(
            interactor: interactor,
            viewController: viewController,
            appDetailsBuildable: component.appDetailsBuildable
        )
    }
}

//
//  SearchHomeBuilder.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import RIBs

protocol SearchHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchHomeComponent: Component<SearchHomeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchHomeBuildable: Buildable {
    func build(withListener listener: SearchHomeListener) -> SearchHomeRouting
}

final class SearchHomeBuilder: Builder<SearchHomeDependency>, SearchHomeBuildable {

    override init(dependency: SearchHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchHomeListener) -> SearchHomeRouting {
        _ = SearchHomeComponent(dependency: dependency)
        let viewController = SearchHomeViewController()
        let interactor = SearchHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchHomeRouter(interactor: interactor, viewController: viewController)
    }
}

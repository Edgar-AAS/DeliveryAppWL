//
//  HomeBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 24/04/24.
//

import Foundation

class HomeBuilder {
    static func build(coordinator: Coordinator) -> HomeViewController {
        let localData = LocalData(resource: "ProductCategories")
        let viewModel = HomeViewModel(httpGetService: localData)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}

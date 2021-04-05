//
//  AppRouter.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import UIKit
import Swinject
import RxSwift

//sourcery: AutoMockable
protocol AppRouterType: BaseRouterType {
    func startJourney(window: UIWindow)
}

struct AppRouter: AppRouterType {
    private let resolver: Resolver
    private let storyboard: UIStoryboard
    
    init(resolver: Resolver) {
        self.resolver = resolver
        self.storyboard = UIStoryboard(name: "Cars", bundle: nil)
    }
    
    func startJourney(window: UIWindow) {
        guard let viewController =  storyboard.instantiateViewController(identifier: "ManufacturersViewController")  as? ManufacturersViewController else {
            return
        }
        let viewModel = resolver.resolve(ManufacturersViewModel.self)
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

//
//  BaseRouterType.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import UIKit

//sourcery: AutoMockable
public protocol BaseRouterType {
    func push(view: ViewControllerType, on sender: ViewControllerType)
    func pop(view: ViewControllerType)
}

public extension BaseRouterType {
    func push(view: ViewControllerType, on sender: ViewControllerType) {
        sender.push(view, animated: true)
    }

    func pop(view: ViewControllerType) {
        view.pop(animated: true)
    }
}


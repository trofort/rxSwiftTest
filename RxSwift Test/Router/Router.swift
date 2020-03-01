//
//  Router.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/1/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift

protocol Routable where Self: UIViewController {}

final class Router {
    
    // MARK: Private properties
    private var navigationController: UINavigationController
    
    // MARK: Init
    init(_ nc: UINavigationController) {
        navigationController = nc
    }
    
    // MARK: Public Methods
    func push(_ module: Routable) {
        navigationController.pushViewController(module as UIViewController,
                                                animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}

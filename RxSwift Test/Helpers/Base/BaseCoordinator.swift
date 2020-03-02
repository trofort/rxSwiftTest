//
//  BaseCoordinator.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/1/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift
import RxCocoa

protocol Coordinator: class {
    func start()
}

class BaseCoordinator: Coordinator {
    
    // MARK: Private properties
    private var children = [Coordinator]()
    
    // MARK: Public Methods
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        if children.contains(where: { $0 === coordinator }) {
            return
        }
        children.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        children.removeAll(where: { $0 === coordinator })
    }
}

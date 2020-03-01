//
//  AppCoordinator.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/1/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift

final class AppCoordinator: BaseCoordinator {
    
    // MARK: Private properties
    private let router: Router
    private let disposeBag = DisposeBag()
    
    // MARK: Init
    init(with router: Router) {
        self.router = router
    }
    
    // MARK: Public methods
    override func start() {
        onAuthModule()
    }
    
    // MARK: Private methods
    private func onAuthModule() {
        let coordinator = AuthCoordinator(with: router)
        
        coordinator.toMainFlow
            .subscribe(onCompleted: { [weak self] in
                self?.onMainModule()
            }).disposed(by: disposeBag)
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func onMainModule() {
        print("Show main module")
    }
}

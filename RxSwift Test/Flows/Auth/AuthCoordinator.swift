//
//  AuthCoordinator.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift

final class AuthCoordinator {
    
    // MARK: Private properties
    private let router: UINavigationController
    private var disposeBag = DisposeBag()
    
    // MARK: Init
    //FIXME: - change to Router class
    init(with router: UINavigationController) {
        self.router = router
    }
    
    // MARK: Public methods
    func start() {
        onLoginModule()
    }
    
    //MARK: onModule methods
    private func onLoginModule() {
        let authModule = ModuleFactory.auth.login
        
        authModule.loggedIn
            .subscribe(onNext: {
                print("change screen")
            }).disposed(by: disposeBag)
        
        router.pushViewController(authModule as UIViewController, animated: true)
    }
}

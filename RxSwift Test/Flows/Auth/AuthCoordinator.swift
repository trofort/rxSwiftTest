//
//  AuthCoordinator.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift

protocol AuthCoordinatorProtocol {
    var toMainFlow: PublishSubject<Void> { get }
}

final class AuthCoordinator: Coordinator, AuthCoordinatorProtocol {
    
    // MARK: Private properties
    private let router: Router
    private var disposeBag = DisposeBag()
    
    // MARK: AuthCoordinatorProtocol property
    var toMainFlow = PublishSubject<Void>()
    
    // MARK: Init
    //FIXME: - change to Router class
    init(with router: Router) {
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
            .bind(to: toMainFlow)
            .disposed(by: disposeBag)
        
        router.push(authModule)
    }
}

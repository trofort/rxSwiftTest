//
//  AuthCoordinator.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift
import RxRelay

protocol AuthCoordinatorProtocol {
    var toMainFlow: PublishRelay<Void> { get }
}

final class AuthCoordinator: Coordinator, AuthCoordinatorProtocol {
    
    // MARK: Private properties
    private let router: Router
    private var disposeBag = DisposeBag()
    private let updateNickname = PublishRelay<String?>()
    
    // MARK: AuthCoordinatorProtocol property
    var toMainFlow = PublishRelay<Void>()
    
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
        
        authModule.moveFromLogin
            .bind(to: toMainFlow)
            .disposed(by: disposeBag)
        
        authModule.moveToRegister
            .subscribe(onNext: { [weak self] in
                self?.onRegisterModule()
            }).disposed(by: disposeBag)
        
        updateNickname.bind(to: authModule.updatedNickname).disposed(by: disposeBag)
        
        router.push(authModule)
    }
    
    private func onRegisterModule() {
        let registerModule = ModuleFactory.auth.register
        
        registerModule.registered?
            .subscribe(onNext: { [weak self] nickname in
                self?.updateNickname.accept(nickname)
                self?.router.pop()
            }).disposed(by: disposeBag)
        
        router.push(registerModule)
    }
}

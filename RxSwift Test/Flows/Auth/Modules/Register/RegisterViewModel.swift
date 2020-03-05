//
//  RegisterViewModel.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/3/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

protocol RegisterViewModelProtocol where Self: Routable {
    var registered: Observable<String>? { get }
}

final class RegisterViewModel: BaseViewModel, Routable {
    
    // MARK: Private properties
    private lazy var authService = AuthService()
    
    private var registerView: RegisterViewProtocol {
        return view as! RegisterViewProtocol
    }
    
    // MARK: Setup methods
    override func setup() {
        super.setup()
        
        authService.errorCatched.bind(to: errorCatcher).disposed(by: disposeBag)
    }
    
    override func setupView() {
        registerView.setup()
        
        registerView.registerTapped.subscribe(onNext: { [weak self] in
            self?.authService.register(nickname: $0,
                                       password: $1,
                                       confirmPassword: $2)
        }).disposed(by: disposeBag)
    }
}

// MARK: - RegisterViewModelProtocol
extension RegisterViewModel: RegisterViewModelProtocol {
    var registered: Observable<String>? {
        return authService.registerCompleted
    }
}


//
//  LoginViewModel.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginViewModelProtocol where Self: Routable {
    var moveFromLogin: Observable<Void> { get }
    var moveToRegister: Observable<Void> { get }
    var updatedNickname: AnyObserver<String?> { get }
}

final class LoginViewModel: BaseViewModel, Routable {

    // MARK: Public property
    var updatedNickname: AnyObserver<String?> {
        return loginView.nicknameTextFieldText
    }
    
    // MARK: Private properties
    private lazy var authService = AuthService()
    
    private var loginView: LoginViewProtocol {
        return view as! LoginViewProtocol
    }
    
    // MARK: Setup methods
    override func setup() {
        super.setup()
    
        authService.errorCatched.bind(to: errorCatcher).disposed(by: disposeBag)
    }
    
    override func setupView() {
        loginView.setup()
        
        loginView.loginTapped
            .subscribe(onNext: { [weak self] in self?.authService.login(nickname: $0, password: $1) })
            .disposed(by: disposeBag)
    }
}

// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    var moveFromLogin: Observable<Void> {
        return authService.loggedIn
    }
    
    var moveToRegister: Observable<Void> {
        return loginView.registerTapped
    }
    
}

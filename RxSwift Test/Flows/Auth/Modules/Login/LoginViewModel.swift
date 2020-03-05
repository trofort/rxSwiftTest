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
    var updatedNickname: Observable<String>? { get set }
}

final class LoginViewModel: BaseViewModel, Routable {

    // MARK: Public property
    var updatedNickname: Observable<String>?
    
    // MARK: Private properties
    private lazy var authService = AuthService()
    
    private var loginView: LoginViewProtocol {
        return view as! LoginViewProtocol
    }
    
    // MARK: Setup methods
    override func setup() {
        super.setup()
        
        updatedNickname?.subscribe(onNext: { [weak self] in self?.setupView(with: $0) }).disposed(by: disposeBag)
        authService.errorCatched.bind(to: errorCatcher).disposed(by: disposeBag)
    }
    
    override func setupView() {
        setupView(with: nil)
        
        loginView.loginTapped.subscribe(onNext: { [weak self] in self?.authService.login(nickname: $0, password: $1) }).disposed(by: disposeBag)
    }
    
    private func setupView(with nickname: String?) {
        loginView.setup(with: nickname)
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

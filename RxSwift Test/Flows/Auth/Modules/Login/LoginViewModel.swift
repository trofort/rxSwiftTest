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
    var loggedIn: PublishRelay<Void> { get }
    var moveToRegister: PublishRelay<Void> { get }
    var nicknameChanged: Observable<String>? { get set }
}

final class LoginViewModel: BaseViewModel, LoginViewModelProtocol, Routable {

    // MARK: LoginViewModelProtocol property
    var loggedIn = PublishRelay<Void>()
    var moveToRegister = PublishRelay<Void>()
    var nicknameChanged: Observable<String>?
    
    // MARK: Private properties
    private lazy var authService = AuthService()
    
    // MARK: Setup methods
    override func setup() {
        super.setup()
        
        nicknameChanged?.subscribe(onNext: { [weak self] in self?.setupView(with: $0) }).disposed(by: disposeBag)
    }
    
    override internal func setupView() {
        guard let view = view as? LoginViewProtocol else { return }
        setupView(with: nil)
        
        view.loginTapped.subscribe(onNext: { [weak self] nickname, password in
            guard let self = self else { return }
            self.authService
                .login(nickname: nickname, password: password)
                .subscribe(onError: { [weak self] in self?.errorCatcher.accept($0) },
                           onCompleted: { [weak self] in self?.loggedIn.accept(()) })
                .disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        view.registerTapped.bind(to: moveToRegister).disposed(by: disposeBag)
    }
    
    private func setupView(with nickname: String?) {
        (view as? LoginViewProtocol)?.setup(with: nickname)
    }
}

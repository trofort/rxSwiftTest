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
    private var loggedInSuccessfull = PublishRelay<Void>()
    private var registerTapped = PublishRelay<Void>()
    
    // MARK: Setup methods
    override func setup() {
        super.setup()
        
        updatedNickname?.subscribe(onNext: { [weak self] in self?.setupView(with: $0) }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        guard let view = view as? LoginViewProtocol else { return }
        setupView(with: nil)
        
        view.loginTapped.subscribe(onNext: { [weak self] nickname, password in
            guard let self = self else { return }
            self.authService
                .login(nickname: nickname, password: password)
                .subscribe(onError: { [weak self] in self?.errorCatcher.accept($0) },
                           onCompleted: { [weak self] in self?.loggedInSuccessfull.accept(()) })
                .disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        view.registerTapped.bind(to: registerTapped).disposed(by: disposeBag)
    }
    
    private func setupView(with nickname: String?) {
        (view as? LoginViewProtocol)?.setup(with: nickname)
    }
}

// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    var moveFromLogin: Observable<Void> {
        return loggedInSuccessfull.asObservable()
    }
    
    var moveToRegister: Observable<Void> {
        return registerTapped.asObservable()
    }
    
}

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
}

final class LoginViewModel: UIViewController, LoginViewModelProtocol, Routable, ErrorSwowing {

    // MARK: LoginViewModelProtocol property
    var loggedIn = PublishRelay<Void>()
    var moveToRegister = PublishRelay<Void>()
    
    // MARK: Private properties
    private let errorCatcher = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Setup methods
    private func setup() {
        errorCatcher.subscribe(onNext: { [weak self] error in
            self?.show(error)
            }).disposed(by: disposeBag)
        
        setupView()
    }
    
    private func setupView() {
        guard let view = view as? LoginViewProtocol else { return }
        view.setup()
        
        view.loginTapped.subscribe(onNext: { [weak self] nickname, password in
            self?.login(nickname: nickname, password: password)
            }).disposed(by: disposeBag)
        view.registerTapped.bind(to: moveToRegister).disposed(by: disposeBag)
    }
    
    // MARK: - Private methods
    private func login(nickname: String?, password: String?) {
        guard let nickname = nickname, nickname != "" else {
            errorCatcher.accept(AuthError.emptyNicknameField)
            return
        }
        
        guard let password = password, password != "" else {
            errorCatcher.accept(AuthError.emptyPasswordField)
            return
        }
        
        NetworkService.login(nickname: nickname, password: password)
            .subscribe(onSuccess: { [weak self] _ in
                print("Login Success")
                self?.loggedIn.accept(())
                }, onError: { [weak self] error in
                    self?.errorCatcher.accept(error)
            }).disposed(by: disposeBag)
    }
}

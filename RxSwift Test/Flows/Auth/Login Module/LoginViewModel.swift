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
    var loggedIn: PublishSubject<Void> { get }
}

final class LoginViewModel: UIViewController, LoginViewModelProtocol, Routable, ErrorSwowing {

    // MARK: LoginViewModelProtocol property
    var loggedIn = PublishSubject<Void>()
    
    // MARK: Private properties
    private let errorCatcher = PublishSubject<Error>()
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
        
        view.login.subscribe(onNext: { [weak self] nickname, password in
            self?.login(nickname: nickname, password: password)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Private methods
    private func login(nickname: String?, password: String?) {
        guard let nickname = nickname, nickname != "" else {
            errorCatcher.onNext(AuthError.emptyNicknameField)
            return
        }
        
        guard let password = password, password != "" else {
            errorCatcher.onNext(AuthError.emptyPasswordField)
            return
        }
        
        NetworkService.login(nickname: nickname, password: password)
            .subscribe(onSuccess: { [weak self] _ in
                print("Login Success")
                self?.loggedIn.onCompleted()
                }, onError: { [weak self] error in
                    self?.errorCatcher.onNext(error)
            }).disposed(by: disposeBag)
    }
}

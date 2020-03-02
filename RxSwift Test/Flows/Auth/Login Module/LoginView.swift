//
//  LoginView.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginViewProtocol {
    func setup()
    var login: PublishSubject<(nickname: String?, password: String?)> { get }
}

final class LoginView: UIView, LoginViewProtocol {
    
    // MARK: Outlets
    @IBOutlet private weak var creditsView: UIView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: private properties
    private var disposeBag = DisposeBag()
    
    // MARK: LoginViewProtocol property
    var login = PublishSubject<(nickname: String?, password: String?)>()
    
    // MARK: setup method
    func setup() {
        setupCreditsView()
        setupLoginButton()
        setupRegisterButton()
    }
    
    // MARK: Private methods
    private func setupCreditsView() {
        creditsView.layer.cornerRadius = 15.0
        creditsView.backgroundColor = .appWhite
    }
    
    private func setupLoginButton() {
        loginButton.backgroundColor = .appPurple
        loginButton.layer.cornerRadius = 5.0
        loginButton.setTitleColor(.appWhite, for: .normal)
        
        loginButton.rx
        .tap
            .subscribe(onNext: { [weak self] in
                self?.login.onNext((nickname: self?.nicknameTextField.text,
                                    password: self?.passwordTextField.text))
            })
        .disposed(by: disposeBag)
    }
    
    private func setupRegisterButton() {
        registerButton.backgroundColor = .appWhite
        registerButton.layer.cornerRadius = 5.0
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.borderColor = UIColor.appPurple.cgColor
        registerButton.setTitleColor(.appPurple, for: .normal)
    }
}

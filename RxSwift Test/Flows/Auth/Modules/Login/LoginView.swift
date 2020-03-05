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
    var loginTapped: Observable<(nickname: String?, password: String?)> { get }
    var registerTapped: Observable<Void> { get }
    var nicknameTextFieldText: AnyObserver<String?> { get }
}

final class LoginView: UIView {
    
    // MARK: Outlets
    @IBOutlet private weak var creditsView: UIView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var nicknameTextFieldText: AnyObserver<String?> {
        return nicknameTextField.rx.text.asObserver()
    }
    
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
    }
    
    private func setupRegisterButton() {
        registerButton.backgroundColor = .appWhite
        registerButton.layer.cornerRadius = 5.0
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.borderColor = UIColor.appPurple.cgColor
        registerButton.setTitleColor(.appPurple, for: .normal)
    }
    
}

// MARK: - LoginViewProtocol
extension LoginView: LoginViewProtocol {
    var loginTapped: Observable<(nickname: String?, password: String?)> {
        return loginButton.rx
                .tap
                .map({ [weak self] in (nickname: self?.nicknameTextField.text,
                                       password: self?.passwordTextField.text) })
                .asObservable()
    }
    
    var registerTapped: Observable<Void> {
        return registerButton.rx.tap.asObservable()
    }
}

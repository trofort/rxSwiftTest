//
//  RegisterView.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/3/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RegisterViewProtocol {
    func setup()
    var registerTapped: Observable<(nickname: String?, password: String?, confirmPassword: String?)> { get }
}

final class RegisterView: UIView {
    
    //MARK: Outlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    // MARK: Setup methods
    func setup() {
        setupBackgroundView()
        setupRegisterButton()
    }
    
    private func setupBackgroundView() {
        backgroundView.layer.cornerRadius = 15.0
        backgroundView.backgroundColor = .appWhite
    }
    
    private func setupRegisterButton() {
        registerButton.backgroundColor = .appPurple
        registerButton.setTitleColor(.appWhite, for: .normal)
        registerButton.layer.cornerRadius = 5.0
    }
}

// MARK: - RegisterViewProtocol
extension RegisterView: RegisterViewProtocol {
    var registerTapped: Observable<(nickname: String?, password: String?, confirmPassword: String?)> {
        return registerButton.rx
        .tap
        .map({ [weak self] in (nickname: self?.nicknameTextField.text,
                               password: self?.passwordTextField.text,
                               confirmPassword: self?.confirmPasswordTextField.text) })
        .asObservable()
    }
}

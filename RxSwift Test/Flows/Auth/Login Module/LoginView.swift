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
    func login(nickname: String, password: String)
}

final class LoginView: UIView {
    
    // MARK: Outlets
    @IBOutlet private weak var loginButton: UIButton!
    
    // MARK: private properties
    private var disposeBag = DisposeBag()
    
    // MARK: setup method
    func setup(with viewModel: LoginViewProtocol) {
        loginButton.rx
            .tap
            .subscribe(onNext: { viewModel.login(nickname: "nick", password: "pass") })
            .disposed(by: disposeBag)
    }
    
}

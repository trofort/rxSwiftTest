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

final class LoginViewModel: UIViewController, LoginViewProtocol, LoginViewModelProtocol, Routable {

    // MARK: LoginViewModelProtocol property
    var loggedIn = PublishSubject<Void>()
    
    // MARK: Private properties
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: SetupView
    private func setupView() {
        (view as? LoginView)?.setup(with: self)
    }
    
    // MARK: - LoginViewProtocol methods
    func login(nickname: String, password: String) {
        print("LoggIn Start")
        NetworkService.login(nickname: nickname, password: password)
            .subscribe(onSuccess: { [weak self] _ in
                print("Login Success")
                self?.loggedIn.onCompleted()
                }, onError: { _ in
                    print("Login error")
            }).disposed(by: disposeBag)
    }
}

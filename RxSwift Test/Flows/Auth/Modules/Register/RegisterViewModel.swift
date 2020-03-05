//
//  RegisterViewModel.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/3/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

protocol RegisterViewModelProtocol where Self: Routable {
    var registered: Observable<String>? { get }
}

final class RegisterViewModel: BaseViewModel, Routable {
    
    // MARK: Private properties
    private lazy var authService = AuthService()
    private let registrationCompleted = PublishRelay<String>()
    
    // MARK: Setup methods
    override func setupView() {
        guard let view = view as? RegisterViewProtocol else { return }
        
        view.setup()
        
        view.registerTapped.subscribe(onNext: { [weak self] nickname, password, confirmPassword in
            guard let self = self else { return }
            self.authService.register(nickname: nickname, password: password, confirmPassword: confirmPassword)
                .subscribe(onNext: { [weak self] in self?.registrationCompleted.accept($0) },
                           onError: { [weak self] in self?.errorCatcher.accept($0) })
                .disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}

// MARK: - RegisterViewModelProtocol
extension RegisterViewModel: RegisterViewModelProtocol {
    var registered: Observable<String>? {
        return registrationCompleted.asObservable()
    }
}


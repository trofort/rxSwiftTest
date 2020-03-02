//
//  ModuleFactory.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

final class ModuleFactory {
    static let auth = AuthModuleFactory()
}

final class AuthModuleFactory {
    var login: LoginViewModelProtocol {
        return LoginViewModel(nibName: "LoginView", bundle: nil)
    }
}

//
//  AuthService.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/3/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class AuthService {
    
    // MARK: Private propeties
    private let disposeBag = DisposeBag()
    
    private var registerTask = PublishRelay<String>()
    private var loginTask = PublishRelay<Void>()
    private var errorCatcher = PublishRelay<Error>()
    
    // MARK: Public observers
    var registerCompleted: Observable<String> {
        return registerTask.asObservable()
    }
    
    var loggedIn: Observable<Void> {
        return loginTask.asObservable()
    }
    
    var errorCatched: Observable<Error> {
        return errorCatcher.asObservable()
    }
    
    // MARK Consts
    private enum Const {
        static let minPasswordLength = 6
    }
    
    // MARK: Public methods
    func login(nickname: String?, password: String?) {
        guard let credits = checkCredits(nickname: nickname, password: password) else { return }
        
        NetworkService.login(nickname: credits.nickname, password: credits.password)
            .subscribe(onError: { [weak self] in self?.errorCatcher.accept($0) },
                       onCompleted: { [weak self] in self?.loginTask.accept(()) })
            .disposed(by: disposeBag)
    }
    
    func register(nickname: String?, password: String?, confirmPassword: String?) {
        guard let credits = checkRegisterCredits(nickname: nickname,
                                                 password: password,
                                                 confirmPassword: confirmPassword) else { return }
        NetworkService.register(nickname: credits.nickname, password: credits.password)
            .subscribe(onError: { [weak self] in self?.errorCatcher.accept($0) },
                       onCompleted: { [weak self] in self?.registerTask.accept(credits.nickname) })
            .disposed(by: disposeBag)
    }
    
    // MARK: Private methods
    private typealias CreditsType = (nickname: String, password: String)?
    
    private func checkCredits(nickname: String?, password: String?) -> CreditsType {
        
        guard let nickname = nickname, nickname != "" else {
            errorCatcher.accept(AuthError.emptyNicknameField)
            return nil
        }
        
        guard let password = password, password != "" else {
            errorCatcher.accept(AuthError.emptyPasswordField)
            return nil
        }
        
        return (nickname: nickname, password: password)
    }
    
    private func checkRegisterCredits(nickname: String?, password: String?, confirmPassword: String?) -> CreditsType {
        
        guard let credits = checkCredits(nickname: nickname, password: password) else {
            return nil
        }
        
        guard let confirmPassword = confirmPassword, confirmPassword != "" else {
            errorCatcher.accept(AuthError.emptyConfirmPasswordField)
            return nil
        }
        
        if credits.password != confirmPassword {
            errorCatcher.accept(AuthError.differentPasswords)
            return nil
        }
        
        if credits.password.count < Const.minPasswordLength {
            errorCatcher.accept(AuthError.shortPassword(minLength: Const.minPasswordLength))
            return nil
        }
        
        return credits
    }
}

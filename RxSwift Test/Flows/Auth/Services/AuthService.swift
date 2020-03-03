//
//  AuthService.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/3/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import Foundation
import RxSwift

final class AuthService {
    // MARK Consts
    private enum Const {
        static let minPasswordLength = 6
    }
    
    // MARK: Public methods
    func login(nickname: String?, password: String?) -> Observable<Void> {
        let credits = checkCredits(nickname: nickname, password: password)
        return Single<Void>.create { single in
            
            if let error = credits.error {
                single(.error(error))
                return Disposables.create()
            }
            
            let loginTask = NetworkService.login(nickname: credits.nickname,
                                                 password: credits.password)
                                .subscribe(onError: { single(.error($0)) },
                                           onCompleted: { single(.success(())) })
            return Disposables.create { loginTask.dispose() }
        }.asObservable()
    }
    
    func register(nickname: String?, password: String?, confirmPassword: String?) -> Observable<String> {
        let credits = checkRegisterCredits(nickname: nickname, password: password, confirmPassword: confirmPassword)
        return Single<String>.create { single in

            if let error = credits.error {
                single(.error(error))
                return Disposables.create()
            }
            
            let registerTask = NetworkService.register(nickname: credits.nickname,
                                                       password: credits.password)
                                    .subscribe(onError: { single(.error($0)) },
                                               onCompleted: { single(.success(credits.nickname)) })
            return Disposables.create { registerTask.dispose() }
        }.asObservable()
    }
    
    // MARK: Private methods
    private typealias CreditsType = (nickname: String, password: String, error: Error?)
    
    private func checkCredits(nickname: String?, password: String?) -> CreditsType {
        
        guard let nickname = nickname, nickname != "" else {
            return (nickname: "", password: "", error: AuthError.emptyNicknameField)
        }
        
        guard let password = password, password != "" else {
            return (nickname: "", password: "", error: AuthError.emptyPasswordField)
        }
        
        return (nickname: nickname, password: password, error: nil)
    }
    
    private func checkRegisterCredits(nickname: String?, password: String?, confirmPassword: String?) -> CreditsType {
        
        let credits = checkCredits(nickname: nickname, password: password)
        
        if let error = credits.error {
            return (nickname: "", password: "", error: error)
        }
        
        guard let confirmPassword = confirmPassword, confirmPassword != "" else {
            return (nickname: "", password: "", error: AuthError.emptyConfirmPasswordField)
        }
        
        if credits.password != confirmPassword {
            return (nickname: "", password: "", error: AuthError.differentPasswords)
        }
        
        if credits.password.count < Const.minPasswordLength {
            return (nickname: "", password: "", error: AuthError.shortPassword(minLength: Const.minPasswordLength))
        }
        
        return credits
    }
}

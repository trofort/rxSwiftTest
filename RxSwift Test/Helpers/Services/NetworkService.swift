//
//  NetworkService.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import RxSwift
import RxCocoa

final class NetworkService {
    
    class func login(nickname: String, password: String) -> Observable<Void> {
        return Single<Void>.create { single in
            print("Logged in with \(nickname)")
            single(.success(()))
            return Disposables.create()
        }.asObservable()
    }
    
    class func register(nickname: String, password: String) -> Observable<Void> {
        return Single<Void>.create { single in
            print("Registered with \(nickname)")
            single(.success(()))
            return Disposables.create()
        }.asObservable()
    }
}

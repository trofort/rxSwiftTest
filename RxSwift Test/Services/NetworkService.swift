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
    
    class func login(nickname: String, password: String) -> Single<Void> {
        return Single<Void>.create { single in
            print("Answer responsed")
            single(.success(()))
            return Disposables.create()
        }
    }
}

//
//  AuthErrors.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/2/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import Foundation

enum AuthError: Error, LocalizedError {
    
    case emptyNicknameField
    case emptyPasswordField
    
    var errorDescription: String? {
        switch self {
        case .emptyNicknameField: return "Nickname field is empty"
        case .emptyPasswordField: return "Password field is empty"
        }
    }
}

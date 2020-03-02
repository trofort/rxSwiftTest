//
//  ErrorSwowing.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/2/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit

protocol ErrorSwowing where Self: UIViewController {  }

extension ErrorSwowing {
    
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
}

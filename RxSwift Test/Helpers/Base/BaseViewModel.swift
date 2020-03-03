//
//  BaseViewModel.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/3/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class BaseViewModel: UIViewController, ErrorSwowing {
    
    // MARK: Internal properties
    internal let disposeBag = DisposeBag()
    internal let errorCatcher = PublishRelay<Error>()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Setup methods
    func setup() {
        errorCatcher.subscribe(onNext: { [weak self] error in
            self?.show(error)
        }).disposed(by: disposeBag)
        
        setupView()
    }
    
    func setupView() {
        //should be overriden
    }
}

//
//  AppDelegate.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 2/28/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let nc = UINavigationController()
        window?.rootViewController = nc
        
        let router = Router(nc)
        appCoordinator = AppCoordinator(with: router)
        appCoordinator?.start()
        
        return true
    }

}


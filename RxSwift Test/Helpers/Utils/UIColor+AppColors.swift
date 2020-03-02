//
//  UIColor+AppColors.swift
//  RxSwift Test
//
//  Created by Максим Деханов on 3/2/20.
//  Copyright © 2020 Максим Деханов. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: alpha)
    }
    
    class var appPurple: UIColor {
        return UIColor(155, 15, 200)
    }
    
    class var appWhite: UIColor {
        return UIColor(255, 255, 255)
    }
}

//
//  UITextFieldExt.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout

extension UITextField{
    func leftSpace(_ space: CGFloat) {
        let spacer = UIView()
        spacer.pin.width(space).height(of: self)
        leftView = spacer
        leftViewMode = .always
    }
}

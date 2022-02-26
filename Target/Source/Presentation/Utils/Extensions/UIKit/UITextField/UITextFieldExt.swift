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
    func rightSpace(_ space: CGFloat) {
        let spacer = UIView()
        spacer.pin.width(space).height(of: self)
        rightView = spacer
        rightViewMode = .always
    }
    func addLeftImage(image: UIImage, space: CGFloat = 10) {
        let leftImage = UIImageView(image: image)
        let view = UIView()
        view.addSubViews(leftImage)
        leftImage.pin.left(space).vCenter()
        self.leftView = view
        self.leftViewMode = .always
    }
    func addRightImage(image: UIImage, space: CGFloat = 10) {
        let rightImage = UIImageView(image: image)
        let view = UIView()
        view.addSubViews(rightImage)
        rightImage.pin.right(space).vCenter()
        self.rightView = view
        self.rightViewMode = .always
    }
}

//
//  SignUpTextField.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SignUpTextField: UITextField{
    init(){
        super.init(frame: .zero)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        self.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        self.leftSpace(6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

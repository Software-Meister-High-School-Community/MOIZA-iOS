//
//  SignInTextField.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/07.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SignInTextField: UITextField{
    init(){
        super.init(frame: .zero)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        self.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        self.textColor = MOIZAAsset.moizaGray5.color
        self.leftSpace(14)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

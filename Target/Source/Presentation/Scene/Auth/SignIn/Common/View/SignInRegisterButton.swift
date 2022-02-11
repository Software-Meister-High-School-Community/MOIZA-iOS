//
//  SignInRegisterButton.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/11.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SignInRegisterButton: UIButton{
    init(text: String){
        super.init(frame: .zero)
        self.setTitle("", for: .normal)
        self.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        self.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


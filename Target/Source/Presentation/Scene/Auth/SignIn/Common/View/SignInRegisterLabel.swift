//
//  SignInRegisterLabel.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/10.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SignInRegisterLabel: UILabel{
    init(text: String){
        super.init(frame: .zero)
        self.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        self.textColor = MOIZAAsset.moizaGray2.color
        self.text = text
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SignInOptionsLabel.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/07.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SignInOptionsLabel: UILabel{
    init(){
        super.init(frame: .zero)
        self.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        self.textColor = MOIZAAsset.moizaGray1.color
        self.text = text
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

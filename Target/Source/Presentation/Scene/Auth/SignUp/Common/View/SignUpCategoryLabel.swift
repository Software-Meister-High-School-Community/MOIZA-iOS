//
//  SignUpCategoryLabel.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/02.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SignUpCategoryLabel: UILabel{
    // MARK: - Init
    init(text: String) {
        super.init(frame: .zero)
        self.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

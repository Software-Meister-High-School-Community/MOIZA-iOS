//
//  NextButton.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class NextButton: UIButton{
    // MARK: - Properties
    init(title: String, color: UIColor = MOIZAAsset.moizaPrimaryBlue.color){
        super.init(frame: .zero)
        self.layer.cornerRadius = 18
        self.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 14)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

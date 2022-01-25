//
//  OnBoardingButton.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class OnBoardingButton: UIButton{
    // MARK: - Init
    init(text: String, foregroundColor: UIColor, backgroundColor: UIColor){
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(foregroundColor, for: .normal)
        self.backgroundColor = backgroundColor
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
private extension OnBoardingButton{
    func configureButton(){
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        self.layer.cornerRadius = 6
    }
}

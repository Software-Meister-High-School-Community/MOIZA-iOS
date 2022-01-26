//
//  SubTitleLabel.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class SubTitleLabel: UILabel{
    // MARK: - Init
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension SubTitleLabel{
    func configureView(){
        self.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 20)
        self.textColor = .black
    }
}

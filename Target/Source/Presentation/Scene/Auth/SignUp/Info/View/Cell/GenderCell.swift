//
//  GenderCell.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import RxSwift
import Then
import PinLayout

final class GenderCell: baseCollectionViewCell<Gender>{
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.textAlignment = .center
    }
    
    override var isSelected: Bool{
        didSet {
            self.backgroundColor = isSelected ? MOIZAAsset.moizaPrimaryYellow.color : MOIZAAsset.moizaGray1.color
        }
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(titleLabel)
    }
    override func setLayout() {
        titleLabel.pin.all(11)
    }
    override func bind(_ model: Gender) {
        titleLabel.text = model == .male ? "남" : "여"
    }
}

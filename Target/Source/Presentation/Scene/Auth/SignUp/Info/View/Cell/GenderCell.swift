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

final class GenderCell: BaseCollectionViewCell<Gender>{
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.textAlignment = .center
    }
    
    override var isSelected: Bool{
        didSet {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.backgroundColor = isSelected ? MOIZAAsset.moizaPrimaryYellow.color : MOIZAAsset.moizaDark2.color
            } else {
                self.backgroundColor = isSelected ? MOIZAAsset.moizaPrimaryYellow.color : MOIZAAsset.moizaGray1.color
            }
        }
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(titleLabel)
    }
    override func setLayout() {
        titleLabel.pin.all(11)
    }
    override func configureCell() {
        self.backgroundColor = .clear
    }
    override func bind(_ model: Gender) {
        titleLabel.text = model.display
    }
    override func darkConfigure() {
        backgroundColor = MOIZAAsset.moizaDark2.color
    }
}

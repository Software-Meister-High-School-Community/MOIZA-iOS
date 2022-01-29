//
//  SchoolCell.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Then
import PinLayout
import RxCocoa

final class SchoolCell: baseTableViewCell<School>{
    // MARK: - Properties
    private let view = UIView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
    }
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private var checkmarkImage = UIImage(systemName: "checkmark")?.downSample(size: .init(width: 12, height: 12))
    private let checkMark = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")?.tintColor(.clear).downSample(size: .init(width: 12, height: 12))
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(view)
        view.addSubViews(titleLabel, checkMark)
    }
    override func setLayout() {
        view.pin.horizontally(0).vertically(3)
        titleLabel.pin.all(11)
        checkMark.pin.centerRight(15).height(12).width(12)
    }
    override func configureCell() {
        self.selectionStyle = .none
    }
    override func bind(_ model: School) {
        titleLabel.text = model.rawValue
    }
    
    // MARK: - OpenMethod
    public func selectItem(){
        view.backgroundColor = MOIZAAsset.moizaPrimaryYellow.color
        titleLabel.textColor = .white
        checkMark.image = checkmarkImage?.tintColor(.white)
    }
    public func deselectItem(){
        view.backgroundColor = .white
        titleLabel.textColor = MOIZAAsset.moizaGray5.color
        checkMark.image = checkmarkImage?.tintColor(.clear)
    }
}

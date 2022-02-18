//
//  IconCategoryView.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import Then

final class IconCategoryView: UIView {
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = MOIZAAsset.moizaLogo.image.withRenderingMode(.alwaysOriginal).downSample(size: .init(width: 52, height: 39))
    }
    
    override func layoutSubviews() {
        logoImageView.pin.center()
    }
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addSubViews(logoImageView)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

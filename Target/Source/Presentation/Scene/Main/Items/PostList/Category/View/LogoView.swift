//
//  LogoView.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import Then

final class LogoView: UIView {
    // MARK: - Properties
    private let icon = UIImageView().then {
        $0.image = MOIZAAsset.moizaSymbol.image.withRenderingMode(.alwaysOriginal)
    }
    
    // MARK: - Init
    override func layoutSubviews() {
        icon.pin.center().width(50%).height(36.7%)
    }
    init() {
        super.init(frame: .zero)
        addSubViews(icon)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

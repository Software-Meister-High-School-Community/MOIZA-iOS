//
//  MoizaRadioButton.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import M13Checkbox

final class MoizaRadioButton: M13Checkbox{
    init() {
        super.init(frame: .zero)
        self.markType = .radio
        self.boxType = .circle
        self.tintColor = MOIZAAsset.moizaPrimaryYellow.color
        self.secondaryCheckmarkTintColor = .white
        self.checkmarkLineWidth = 4.5
        self.boxLineWidth = 1
        self.secondaryTintColor = MOIZAAsset.moizaGray3.color
        self.stateChangeAnimation = .bounce(.fill)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

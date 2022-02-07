//
//  SignUpProgress.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import FlexibleSteppedProgressBar
import Hero

final class SignUpProgress: FlexibleSteppedProgressBar{
    init(){
        super.init(frame: .zero)
        self.numberOfPoints = 3
        self.lineHeight = 1.5
        self.viewBackgroundColor = .clear
        self.currentSelectedCenterColor = MOIZAAsset.moizaPrimaryBlue.color
        self.selectedBackgoundColor = MOIZAAsset.moizaPrimaryBlue.color
        self.selectedOuterCircleStrokeColor = .clear
        self.hero.id = "progress"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

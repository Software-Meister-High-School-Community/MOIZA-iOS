//
//  SignUpInfoVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import FlexibleSteppedProgressBar
import Hero

final class SignUpInfoVC: baseVC<SignUpInfoReactor>{
    // MARK: - Properties
    private let progressBar = FlexibleSteppedProgressBar().then {
        $0.numberOfPoints = 3
        $0.currentSelectedCenterColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.selectedOuterCircleStrokeColor = .clear
        $0.currentIndex = 1
        $0.hero.id = "progress"
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(progressBar)
    }
    override func setLayout() {
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(10)
        }
    }
    override func configureVC() {
        
    }
}

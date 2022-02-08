//
//  GraduateAuthVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class GraduateAuthVC: baseVC<GraduateAuthReactor> {
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let rootConainter = UIView()
    
    // MARK: - UI
    override func setUp() {
        
    }
    override func addView() {
        view.addSubViews(rootConainter)
    }
    override func setLayoutSubViews() {
        
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "졸업생 인증")
    }
}

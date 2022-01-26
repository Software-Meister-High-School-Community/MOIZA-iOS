//
//  SignUpTOSVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar
import Hero
import M13Checkbox

final class SignUpTOSVC: baseVC<SignUpTOSReactor>{
    // MARK: - Properties
    private let progressBar = FlexibleSteppedProgressBar().then {
        $0.numberOfPoints = 3
        $0.currentSelectedCenterColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.selectedOuterCircleStrokeColor = .clear
        $0.hero.id = "progress"
    }
    private let titleLabel = SubTitleLabel(title: "약관동의")
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.text = "원활한 모이자 활동과 서비스 제공을 위해\n꼭 필요한 정보입니다."
    }
    private let subView = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
    }
    private let allAgree = M13Checkbox().then {
        $0.markType = .radio
        $0.boxType = .circle
        $0.tintColor = MOIZAAsset.moizaPrimaryYellow.color
        $0.secondaryCheckmarkTintColor = .white
        $0.checkmarkLineWidth = 4
        $0.boxLineWidth = 1
        $0.secondaryTintColor = MOIZAAsset.moizaGray3.color
        $0.stateChangeAnimation = .bounce(.fill)
    }
    
    // MARK: - UI
    override func setUp() {
        progressBar.delegate = self
    }
    override func addView() {
        view.addSubViews(progressBar, titleLabel, descriptionLabel, subView)
        subView.addSubViews(allAgree)
    }
    override func setLayout() {
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(10)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalTo(progressBar.snp.bottom).offset(30)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        subView.snp.makeConstraints {
            $0.height.equalTo(bound.height*0.5086)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        allAgree.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(23)
            $0.width.height.equalTo(24)
        }
    }
    override func configureVC() {
        
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "회원가입")
    }
}

// MARK: - Extension
extension SignUpTOSVC: FlexibleSteppedProgressBarDelegate{
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

//
//  OnBoardingVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class OnBoardingVC: baseVC<OnBoardingReactor>{
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = MOIZAAsset.moizaLogo.image
        $0.contentMode = .scaleAspectFit
    }
    private let signUpButton = OnBoardingButton(text: "회원가입", foregroundColor: .white, backgroundColor: MOIZAAsset.moizaPrimaryBlue.color)
    private let signInButton = OnBoardingButton(text: "로그인", foregroundColor: .black, backgroundColor: .white).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private let mainStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    // MARK: - UI
    override func addView() {
        mainStack.addArrangeSubviews(signUpButton, signInButton)
        view.addSubViews(mainStack, logoImageView)
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.252)
            $0.top.equalToSuperview().offset(bound.height*0.399)
            $0.bottom.equalToSuperview().offset(-bound.height*0.5531)
        }
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        signInButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        mainStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    override func configureVC() {
        
    }
}

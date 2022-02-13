//
//  OnBoardingVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import RxCocoa
import Hero
import PinLayout
import FlexLayout

final class OnBoardingVC: baseVC<OnBoardingReactor>{
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = MOIZAAsset.moizaLogo.image
        $0.contentMode = .scaleAspectFit
    }
    private let signUpButton = OnBoardingButton(text: "회원가입", foregroundColor: MOIZAAsset.moizaGray1.color, backgroundColor: MOIZAAsset.moizaPrimaryBlue.color).then {
        $0.hero.id = "progress"
    }
    private let signInButton = OnBoardingButton(text: "로그인", foregroundColor: MOIZAAsset.moizaGray6.color, backgroundColor: MOIZAAsset.moizaGray1.color).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray6.color.cgColor
        $0.hero.id = "logo"
    }
    private let mainContainer = UIView()
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(mainContainer, logoImageView)
    }
    override func setLayoutSubViews() {
        logoImageView.pin.top(39%).horizontally(25%).bottom(55%)
        mainContainer.pin.bottom(view.pin.safeArea.bottom + 10).horizontally(16).height(108)
        
        mainContainer.flex.direction(.columnReverse).define { flex in
            flex.addItem(signInButton).width(100%).height(50)
            flex.addItem(signUpButton).width(100%).height(50).marginBottom(8)
        }
        mainContainer.flex.layout()
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    override func configureNavigation() {
        self.navigationItem.configBack()
        
    }
    
    // MARK: - Reactor
    override func bindView(reactor: OnBoardingReactor) {
        signUpButton.rx.tap
            .map { _ in Reactor.Action.signUpButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        signInButton.rx.tap
            .map { _ in Reactor.Action.signInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

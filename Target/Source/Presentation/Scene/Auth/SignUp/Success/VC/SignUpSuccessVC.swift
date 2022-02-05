//
//  SignUpSuccessVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/05.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import Hero
import RxCocoa

final class SignUpSuccessVC: baseVC<SignUpSuccessReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let checkMarkImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle.fill")?.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
        $0.contentMode = .scaleAspectFit
        $0.hero.id = "progress"
    }
    private let successLabel = UILabel().then {
        $0.text = "회원가입이 완료되었습니다."
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textAlignment = .center
    }
    private let signInButton = NextButton(title: "로그인하기").then {
        $0.hero.id = "next"
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.alignItems(.center).define { flex in
            flex.addItem(checkMarkImageView).marginTop(15%).width(56).height(56)
            flex.addItem(successLabel).marginTop(5).width(100%)
            flex.addItem(signInButton).marginTop(8%).width(97).height(18)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "회원가입")
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SignUpSuccessReactor) {
        signInButton.rx.tap
            .map { Reactor.Action.signUpButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}


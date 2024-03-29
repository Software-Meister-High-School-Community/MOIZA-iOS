//
//  CertEmail.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/11.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import RxKeyboard
import Then

final class CertEmailVC: BaseVC<CertEmailReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.text = "이메일로 인증"
        $0.numberOfLines = 1
    }
    private let emailTextField = SignUpTextField().then {
        $0.placeholder = "인증번호"
        $0.leftSpace(14)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let reCertButton = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.setTitle("인증번호 재발송", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private var reCertLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaTheme.color
        $0.text = "인증번호를 다시 입력해주세요"
        $0.isHidden = true
    }
    private let nextButton = NextButton(title: "다음 단계")
    // MARK: - UI
    override func addView() {
        view.addSubview(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(16).define { flex in
            flex.addItem(titleLabel)
                .height(23)
                .marginTop(38)
            // MARK: CERT
            flex.addItem()
                .horizontally(0)
                .direction(.row)
                .marginTop(30)
                .define { flex in
                    flex.addItem(emailTextField)
                        .height(40)
                        .width(67%)
                    flex.addItem(reCertButton)
                        .height(40)
                        .width(33%)
                        .marginLeft(7)
                }
            flex.addItem(reCertLabel)
                .marginTop(10)
                .marginLeft(3)
            // MARK: Next
            flex.addItem(nextButton)
                .marginTop(96)
                .width(88)
                .height(36)
                .alignSelf(.end)
        }
    }
    
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "아이디 찾기")
        self.navigationItem.configBack()
    }
    override func darkConfigure() {
        [
            emailTextField, reCertButton
        ].forEach {
            $0.backgroundColor = MOIZAAsset.moizaDark2.color
            $0.layer.borderColor = UIColor.clear.cgColor
        }
    }
    // MARK: - Reactor
    override func bindView(reactor: CertEmailReactor) {
        nextButton.rx.tap
            .map { _ in Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        reCertButton.rx.tap
            .map { _ in Reactor.Action.reCertButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        emailTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateEmail)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: CertEmailReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isValid)
            .withUnretained(self)
            .bind { owner, item in
                owner.nextButton.isEnabled = item
                owner.nextButton.backgroundColor = item ? MOIZAAsset.moizaPrimaryBlue.color : MOIZAAsset.moizaSecondaryBlue.color
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.emailValid)
            .withUnretained(self)
            .bind { owner, item in
                owner.reCertLabel.isHidden = item
                let color = owner.traitCollection.userInterfaceStyle == .dark ? UIColor.clear.cgColor : MOIZAAsset.moizaGray3.color.cgColor
                owner.emailTextField.layer.borderColor = item ? color : MOIZAAsset.moizaTheme.color.cgColor
            }
            .disposed(by: disposeBag)
    }
    
    
}


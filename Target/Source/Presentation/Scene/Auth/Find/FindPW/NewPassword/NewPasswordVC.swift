//
//  ReRegistrationVC.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Then
import RxFlow
import RxCocoa
import ReactorKit
import FlexLayout
import PinLayout
import UIKit

final class NewPasswordVC: BaseVC<NewPasswordReactor> {
    // MARK: - Metric
    enum Metric {
        static let spacingMargin: CGFloat = 40
        static let labelHeight: CGFloat = 40
        static let height: CGFloat = 44
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = .label
        $0.text = "비밀번호 재등록"
    }
    private let newPwdTextField = SignUpTextField().then {
        $0.placeholder = "새 비밀번호"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.leftSpace(14)
    }
    private let newPwdVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    private let pwdHelperLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 11)
        $0.text = "8~16자 영문 대소문자, 숫자, 특수문자를 모두 조합하여 구성해주세요."
        $0.numberOfLines = 0
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let pwdCheckTextField = SignUpTextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.leftSpace(14)
    }
    private let pwdCheckVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    private let pwdCheckInvalidLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 11)
        $0.text = "비밀번호가 일치하지 않습니다. 다시 한번 입력해주세요."
        $0.textColor = MOIZAAsset.moizaTheme.color
        $0.isHidden = true
    }
    private let nextButton = NextButton(title: "다음 단계")
    
    // MARK: - UI
    override func setUp() {
        view.addSubview(rootContainer )
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(16)
            .define { flex in
                flex.addItem(titleLabel)
                    .marginTop(84)
                // MARK: NewPwd
                flex.addItem(newPwdTextField)
                    .marginTop(Metric.spacingMargin)
                    .width(100%)
                    .height(Metric.height)
                    .direction(.rowReverse)
                    .define { flex in
                        flex.addItem(newPwdVisibleButton)
                            .width(24)
                            .height(24)
                            .marginTop(10)
                            .marginRight(10)
                            .marginVertical(10)
                    }
                flex.addItem(pwdHelperLabel)
                    .width(100%)
                    .marginTop(5)
                // MARK: pwdCheck
                flex.addItem(pwdCheckTextField)
                    .marginTop(Metric.spacingMargin)
                    .width(100%)
                    .height(Metric.height)
                    .direction(.rowReverse)
                    .define { flex in
                        flex.addItem(pwdCheckVisibleButton)
                            .width(24)
                            .height(24)
                            .marginRight(10)
                            .marginVertical(10)
                    }
                flex.addItem(pwdCheckInvalidLabel)
                    .width(100%)
                    .marginTop(5)
                // MARK: Next
                flex.addItem(nextButton)
                    .top(Metric.spacingMargin)
                    .width(88)
                    .height(36)
                    .alignSelf(.end)
            }
    }
    override func darkConfigure() {
        [
            newPwdTextField, pwdCheckTextField
        ].forEach{
            $0.backgroundColor = MOIZAAsset.moizaDark2.color
            $0.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: NewPasswordReactor) {
        nextButton.rx.tap
            .map { _ in Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        newPwdTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateNewPassword)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        pwdCheckTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateNewPasswordCheck)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        newPwdVisibleButton.rx.tap
            .map{ Reactor.Action.newPwdVisibleButtinDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        pwdCheckVisibleButton.rx.tap
            .map{ Reactor.Action.newPwdCheckVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: NewPasswordReactor) {
        let sharedState = reactor.state.share(replay: 4).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.newPasswordVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.newPwdTextField.isSecureTextEntry = visible
                owner.newPwdVisibleButton.setImage(UIImage(systemName: visible ? "eye" : "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color),
                for: .normal)
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.newPasswordCheckVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.pwdCheckTextField.isSecureTextEntry = visible
                owner.pwdCheckVisibleButton.setImage(UIImage(systemName: visible ? "eye" : "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.valid)
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.nextButton.isEnabled = item
                owner.nextButton.backgroundColor = item ? MOIZAAsset.moizaPrimaryBlue.color : MOIZAAsset.moizaSecondaryBlue.color
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.newPasswordValid)
            .bind(to: pwdCheckInvalidLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "비밀번호 찾기")
        self.navigationItem.configBack()
    }
}

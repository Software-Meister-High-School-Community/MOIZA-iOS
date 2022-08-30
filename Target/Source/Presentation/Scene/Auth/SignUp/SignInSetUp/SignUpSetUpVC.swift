//
//  SignUpSetUpVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxSwift
import RxCocoa
import PinLayout
import FlexibleSteppedProgressBar
import UIKit
import FlexLayout
import RxKeyboard

final class SignUpSetUpVC: BaseVC<SignUpSetUpReactor>{
    // MARK: - Metric
    enum Metric {
        static let spacingMargin: CGFloat = 40
        static let labelHeight: CGFloat = 40
        static let height: CGFloat = 44
    }
    enum Fonts {
        static let regular11 = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 11)
    }
    
    // MARK: - Properties
    private let progressBar = SignUpProgress().then {
        $0.currentIndex = 1
    }
    private let rootContainer = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let titleLabel = SubTitleLabel(title: "로그인 설정")
    private let idLabel = SignUpCategoryLabel(text: "아이디")
    private let idCheckButton = UIButton().then {
        $0.setTitle("아이디 중복확인", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray6.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.layer.borderColor = MOIZAAsset.moizaGray6.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.alpha = 0.25
    }
    private let idTextField = SignUpTextField()
    
    private let pwdLabel = SignUpCategoryLabel(text: "비밀번호")
    private let pwdTextField = SignUpTextField()
    private let pwdVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    private let pwdHelperLabel = UILabel().then {
        $0.font = Fonts.regular11
        $0.text = "8~16자 영문 대소문자, 숫자, 특수문자를 모두 조합하여 구성해주세요."
        $0.numberOfLines = 0
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let pwdInvalidLabel = UILabel().then {
        $0.font = Fonts.regular11
        $0.text = "비밀번호 조건에 맞지 않습니다."
        $0.textColor = MOIZAAsset.moizaTheme.color
        $0.isHidden = true
    }
    
    private let pwdCheckLabel = SignUpCategoryLabel(text: "비밀번호  확인")
    private let pwdCheckTextField = SignUpTextField()
    private let pwdCheckVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    private let pwdCheckInvalidLabel = UILabel().then {
        $0.font = Fonts.regular11
        $0.text = "비밀번호가 일치하지 않습니다. 다시 한번 입력해주세요."
        $0.textColor = MOIZAAsset.moizaTheme.color
        $0.isHidden = true
    }
    
    private let nextButton = NextButton(title: "다음 단계")
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressBar.currentIndex = 2
    }
    
    // MARK: - UI
    override func setUp() {
        progressBar.delegate = self
    }
    override func addView() {
        scrollView.addSubViews(rootContainer)
        view.addSubViews(scrollView)
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(20).define { flex in
            flex.addItem(progressBar).top(12).height(10)
            flex.addItem(titleLabel).height(Metric.labelHeight).marginTop(Metric.spacingMargin)
            // MARK: Id
            flex.addItem().marginTop(Metric.spacingMargin * 1).width(100%).direction(.row).define { flex in
                flex.addItem(idLabel).height(Metric.labelHeight).shrink(1).width(100%)
                flex.addItem(idCheckButton).height(28).shrink(1).width(100%).alignSelf(.end)
            }
            flex.addItem(idTextField).width(100%).height(Metric.height).marginTop(10)
            // MARK: Password
            flex.addItem().marginTop(Metric.spacingMargin).width(100%).define { flex in
                flex.addItem(pwdLabel).width(100%).height(Metric.labelHeight)
                flex.addItem(pwdTextField).width(100%).height(Metric.height).direction(.rowReverse).define { flex in
                    flex.addItem(pwdVisibleButton).width(24).height(24).marginRight(10).marginVertical(10)
                }
                flex.addItem(pwdHelperLabel).width(100%).marginTop(5)
                flex.addItem(pwdInvalidLabel).width(100%).marginTop(5)
            }
            // MARK: PasswordCheck
            flex.addItem().marginTop(Metric.spacingMargin).width(100%).define { flex in
                flex.addItem(pwdCheckLabel).width(100%).height(Metric.labelHeight)
                flex.addItem(pwdCheckTextField).width(100%).height(Metric.height).direction(.rowReverse).define { flex in
                    flex.addItem(pwdCheckVisibleButton).width(24).height(24).marginRight(10).marginVertical(10)
                }
                flex.addItem(pwdCheckInvalidLabel).width(100%).marginTop(5)
            }
            // MARK: Next
            flex.addItem(nextButton).top(Metric.spacingMargin).width(88).height(36).right(0).alignSelf(.end)
        }
    }
    override func setLayoutSubViews() {
        scrollView.pin.all()
        rootContainer.pin.top().right().left().height(bound.height*1.05)
        
        rootContainer.flex.layout()
        scrollView.contentSize = .init(width: bound.width, height: bound.height*1.05)
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "회원가입")
        self.navigationItem.configBack()
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    override func darkConfigure() {
        [
            idTextField, pwdTextField, pwdCheckTextField, idCheckButton
        ].forEach {
            $0.backgroundColor = MOIZAAsset.moizaDark2.color
            $0.layer.borderColor = UIColor.clear.cgColor
        }
        
        
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SignUpSetUpReactor) {
        idTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateId)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idCheckButton.rx.tap
            .map { Reactor.Action.isIdExistButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updatePassword)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdCheckTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updatePasswordCheck)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdVisibleButton.rx.tap
            .map { Reactor.Action.pwdVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdCheckVisibleButton.rx.tap
            .map { Reactor.Action.pwdCheckVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: SignUpSetUpReactor) {
        let sharedState = reactor.state.share(replay: 6).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.id)
            .map { !$0.isEmpty }
            .do(onNext: { [weak self] empty in
                self?.idCheckButton.isEnabled = empty
            })
            .map { $0 ? 1.0 : 0.25 }
            .bind(to: idCheckButton.rx.alpha)
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.pwdVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.pwdTextField.isSecureTextEntry = visible
                owner.pwdVisibleButton.setImage(UIImage(systemName: visible ? "eye" : "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color),
                                          for: .normal)
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.pwdCheckVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.pwdCheckTextField.isSecureTextEntry = visible
                owner.pwdCheckVisibleButton.setImage(UIImage(systemName: visible ? "eye" : "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color),
                                                     for: .normal)
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
            .map(\.passwordValid)
            .bind(to: pwdInvalidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.passwordCheckedValid)
            .withUnretained(self)
            .bind { owner, valid in
                owner.pwdCheckInvalidLabel.isHidden = valid
                let color = owner.traitCollection.userInterfaceStyle == .dark ? UIColor.clear.cgColor : MOIZAAsset.moizaGray3.color.cgColor
                owner.pwdCheckTextField.layer.borderColor = valid ? color : MOIZAAsset.moizaTheme.color.cgColor
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension SignUpSetUpVC: FlexibleSteppedProgressBarDelegate{
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

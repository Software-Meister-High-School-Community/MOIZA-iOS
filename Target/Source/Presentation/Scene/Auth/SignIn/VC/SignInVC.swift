//
//  SignInVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/07.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Hero
import M13Checkbox
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class SignInVC: baseVC<SignInReactor>{
    
    private let mainContainer = UIView()
    
    private let moizaLogoImageView = UIImageView(image: MOIZAAsset.moizaLogo.image).then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.contentMode = .scaleToFill
        $0.hero.id = "logo"
    }
    private let signInIdTextfield = SignInTextField().then{
        $0.autocapitalizationType = .none
    }
    private let signInPwdTextfield = SignInTextField().then{
        $0.autocapitalizationType = .none
    }
    
    private let pwdVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    
    private let autoLoginButton = MoizaRadioButton()
    private let autoLoginLabel = UILabel().then{
        $0.text = "자동 로그인"
    }
    
    private let saveIdButton = MoizaRadioButton()
    private let saveIdLabel = UILabel().then{
        $0.text = "아이디 저장"
    }
    
    private let loginButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray1.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        $0.layer.cornerRadius = 5
        $0.backgroundColor = MOIZAAsset.moizaSecondaryYellow.color
    }
    
    private let registerButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let findIdButton = UIButton().then{
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let findPwdButton = UIButton().then{
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    
    private let line = DivisionLine()
    private let line2 = DivisionLine()
    
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "로그인")
        self.navigationItem.configBack()
    }
    override func addView() {
        view.addSubViews(mainContainer,moizaLogoImageView)
    }
    override func setLayoutSubViews() {
        mainContainer.pin.all(view.pin.safeArea)
        mainContainer.flex.layout()
    }
    override func setLayout() {
        mainContainer.flex.marginHorizontal(16).define { flex in
            // MARK: - Logo
            flex.addItem(moizaLogoImageView).width(139).height(29).marginTop(30).alignSelf(.center)
            // MARK: - Textfield
            flex.addItem().marginTop(42).define { flex in
                flex.addItem(signInIdTextfield).height(50).width(100%)
                flex.addItem(signInPwdTextfield).height(50).width(100%).marginVertical(12).direction(.rowReverse).define { flex in
                    flex.addItem(pwdVisibleButton).width(24).height(24).marginLeft(10).marginRight(10).marginVertical(12)
                }
            }
            flex.addItem().horizontally(0).direction(.row).define { flex in
            // MARK: - AutoLogin
                flex.addItem().marginTop(24).direction(.row).shrink(1).define { flex in
                    flex.addItem(autoLoginButton).width(24).height(24)
                    flex.addItem(autoLoginLabel).left(10).width(70%).height(24)
                }
            // MARK: - SaveID
                flex.addItem().marginTop(24).direction(.row).shrink(1).define { flex in
                    flex.addItem(saveIdButton).width(24).height(24)
                    flex.addItem(saveIdLabel).left(10).width(70%).width(100%)
                }
            }
            // MARK: - LoginButton
            flex.addItem(loginButton).width(100%).height(50).marginTop(35).alignSelf(.center)
            // MARK: - Additions
            flex.addItem().horizontally(65).define { flex in
                flex.addItem().marginTop(40).direction(.row).shrink(1).define { flex in
                    flex.addItem(registerButton).width(45).height(14)
                    flex.addItem(line).marginLeft(18).marginRight(18)
                    flex.addItem(findIdButton).width(59).height(14)
                    flex.addItem(line2).marginLeft(18).marginRight(18)
                    flex.addItem(findPwdButton).width(70).height(14)
                }
            }
        }
    }
    override func bindView(reactor: SignInReactor) {
        signInIdTextfield.rx.text
            .orEmpty
            .map(Reactor.Action.updateId)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        signInPwdTextfield.rx.text
            .orEmpty
            .map(Reactor.Action.updatePassword)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdVisibleButton.rx.tap
            .map{Reactor.Action.pwdVisibleButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        autoLoginButton.rx.controlEvent(.valueChanged)
            .map{Reactor.Action.autoLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        saveIdButton.rx.controlEvent(.valueChanged)
            .map{Reactor.Action.saveIdButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .map{Reactor.Action.logInButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .map{Reactor.Action.signUpButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        findIdButton.rx.tap
            .map{Reactor.Action.findIdButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        findPwdButton.rx.tap
            .map{Reactor.Action.findPwdButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: SignInReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            
            .map(\.isSignInValid)
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.loginButton.isEnabled = item
                owner.loginButton.backgroundColor = item ? MOIZAAsset.moizaPrimaryYellow.color : MOIZAAsset.moizaSecondaryYellow.color
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.passwordVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.signInPwdTextfield.isSecureTextEntry = visible
                owner.pwdVisibleButton.setImage(UIImage(systemName: visible ? "eye" : "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color),
                                                     for: .normal)
            }
            .disposed(by: disposeBag)
    }
}

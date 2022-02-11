//
//  SignInVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/07.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar
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
    }
    private let signInIdTextfield = SignInTextField()
    private let signInPwdTextfield = SignInTextField()
    
    private let autoLoginButton = MoizaRadioButton()
    private let autoLoginLabel = UILabel().then{
        $0.text = SignInOptions.autoLogin.rawValue
    }
    
    private let saveIdButton = MoizaRadioButton()
    private let saveIdLabel = UILabel().then{
        $0.text = SignInOptions.saveID.rawValue
    }
    
    private let loginButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray1.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        $0.layer.cornerRadius = 5
        $0.backgroundColor = MOIZAAsset.moizaSecondaryYellow.color
    }
    
    private let registerLabel = SignInRegisterButton(text: "회원가입")
    private let findIdLabel = SignInRegisterButton(text: "아이디 찾기")
    private let findPwdLabel = SignInRegisterButton(text: "비밀번호 찾기")
    
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
            flex.addItem().top(40).direction(.column).define { flex in
                flex.addItem(signInIdTextfield).height(50).width(100%).marginBottom(12)
                flex.addItem(signInPwdTextfield).height(50).width(100%)
            }
            flex.addItem().horizontally(0).direction(.row).define { flex in
            // MARK: - AutoLogin
                flex.addItem().marginTop(78).direction(.row).shrink(1).define { flex in
                    flex.addItem(autoLoginButton).width(24).height(24)
                    flex.addItem(autoLoginLabel).left(10).width(70%).height(24)
                }
            // MARK: - SaveID
                flex.addItem().marginTop(78).direction(.row).shrink(1).define { flex in
                    flex.addItem(saveIdButton).width(24).height(24)
                    flex.addItem(saveIdLabel).left(10).width(70%).width(100%)
                }
            }
            // MARK: - LoginButton
            flex.addItem(loginButton).width(100%).height(50).marginTop(35).alignSelf(.center)
        }
    }
}

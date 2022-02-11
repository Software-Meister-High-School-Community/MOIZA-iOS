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

    enum Metric {
        static let spacingMargin: CGFloat = 40
        static let height: CGFloat = 44
        static let labelHeight: CGFloat = 40
    }
    private let mainContainer = UIView()
    
    private let moizaLogoImageView = UIImageView(image: MOIZAAsset.moizaLogo.image).then{
        $0.backgroundColor = .white
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
        $0.setTitleColor(MOIZAAsset.moizaGray6.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        $0.layer.cornerRadius = 5
        $0.backgroundColor = MOIZAAsset.moizaSecondaryYellow.color
    }
    
    private let registerLabel = SignInRegisterLabel(text: "회원가입")
    private let findIdLabel = SignInRegisterLabel(text: "아이디 찾기")
    private let findPwdLabel = SignInRegisterLabel(text: "비밀번호 찾기")
    
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "로그인")
        self.navigationItem.configBack()
        mainContainer.backgroundColor = .gray
    }
    override func addView() {
        view.addSubViews(mainContainer, moizaLogoImageView)
    }
    override func setLayoutSubViews() {
        mainContainer.pin.all(view.pin.safeArea)
        mainContainer.flex.layout()
    }
    override func setLayout() {
        mainContainer.flex.marginHorizontal(20).define { flex in
            flex.addItem(moizaLogoImageView).width(139.61).height(29).top(56).left(106).marginBottom(40)
            // MARK: - Textfield
            flex.addItem().marginTop(Metric.spacingMargin*1).define { flex in
                flex.horizontally(0).direction(.columnReverse).define { flex in
                    flex.addItem(signInIdTextfield).width(100%).height(50)
                    flex.addItem(signInPwdTextfield).width(100%).height(50).marginBottom(12)
                }
                flex.addItem().horizontally(0).direction(.row).define { flex in
                    flex.addItem().direction(.row).shrink(1).define { flex in
                        flex.addItem(autoLoginButton).width(24).height(24)
                        flex.addItem(autoLoginLabel).left(10).width(70%).height(24)
                    }
                    flex.addItem().direction(.row).shrink(1).define { flex in
                        flex.addItem(saveIdButton).width(24).height(24)
                        flex.addItem(saveIdLabel).left(10).width(70%).height(24)
                    }
                }
            }
        }
    }
}

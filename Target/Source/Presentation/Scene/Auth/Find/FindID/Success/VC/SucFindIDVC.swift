//
//  SucFindIDVC.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/14.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Hero
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import RxKeyboard
import Then
import ReactorKit

final class SucFindIDVC: baseVC<SucFindIDReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let nameLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.text = "맹성주"
    }
    private let descLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        $0.textColor = .label
        $0.text = "님의 정보와 일치하는 아이디입니다."
    }
    private let idLabel = UILabel().then {
        $0.text = "maengsunjoo1007"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 20)
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.textAlignment = .center
    }
    private let findPWButton = NextButton(title: "비밀번호 찾기", color: MOIZAAsset.moizaPrimaryYellow.color)
    private let navToSingInButton = NextButton(title: "로그인 하기")
    // MARK: - UI
    override func addView() {
        view.addSubview(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem().horizontally(0).direction(.row).marginTop(120).alignSelf(.center).define { flex in
                flex.addItem(nameLabel).height(18.75)
                flex.addItem(descLabel).height(18.75)
            }
            flex.addItem(idLabel).marginTop(70).height(60).width(100%)
            flex.addItem().horizontally(0).direction(.row).marginTop(90).alignSelf(.center).define { flex in
                flex.addItem(findPWButton).width(113).height(36)
                flex.addItem(navToSingInButton).width(100).height(36).marginLeft(20)
            }
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "아이디 찾기")
        self.navigationItem.configBack()
    }
}

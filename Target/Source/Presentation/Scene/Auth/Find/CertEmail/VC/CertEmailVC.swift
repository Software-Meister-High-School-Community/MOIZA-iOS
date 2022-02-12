//
//  CertEmail.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/11.
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

final class CertEmailVC: baseVC<CertEmailReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = .label
        $0.text = "이메일로 인증"
        $0.numberOfLines = 1
    }
    private let emailTextField = SignUpTextField().then {
        $0.placeholder = "인증번호"
    }
    private let reCertButton = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.titleLabel?.text = "인증번호 재발송"
        $0.backgroundColor = MOIZAAsset.moizaGray4.color
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
            flex.addItem(titleLabel).height(23).marginTop(38)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "아이지 찾기")
        self.navigationItem.configBack()
    }
}


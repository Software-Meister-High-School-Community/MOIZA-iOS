//
//  FindIDVC.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/11.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Hero
import PinLayout
import FlexLayout
import SnapKit
import RxSwift
import RxCocoa
import RxKeyboard
import Then

final class FindIDVC: baseVC<FindIDReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = .label
        $0.text = "이메일로 인증"
        $0.numberOfLines = 1
    }
    private let emailTextField = SignUpTextField().then {
        $0.placeholder = "회원가입 시 입력한 이메일 주소"
        $0.leftSpace(14)
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
            // MARK: CERT
            flex.addItem(emailTextField).marginTop(30).height(40)
            // MARK: Next
            flex.addItem(nextButton).marginTop(127).width(88).height(36).alignSelf(.end)
        }
    }
    override func bindView(reactor: FindIDReactor) {
        nextButton.rx.tap
            .map { _ in Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "아이디 찾기")
        self.navigationItem.configBack()
    }
}


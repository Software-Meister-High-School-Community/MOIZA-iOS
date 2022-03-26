//
//  CheckIDVC.swift
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

final class CheckIDVC: baseVC<CheckIDReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = .label
        $0.text = "아이디를 입력해주세요."
        $0.numberOfLines = 1
    }
    private let idTextField = SignUpTextField().then {
        $0.placeholder = "아이디"
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
            flex.addItem(titleLabel)
                .height(23)
                .marginTop(38)
            // MARK: CERT
            flex.addItem(idTextField)
                .marginTop(30)
                .height(40)
            // MARK: Next
            flex.addItem(nextButton)
                .marginTop(127)
                .width(88)
                .height(36)
                .alignSelf(.end)
        }
    }
    override func bindView(reactor: CheckIDReactor) {
        nextButton.rx.tap
            .map { _ in Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "비밀번호 찾기")
        self.navigationItem.configBack()
    }
}

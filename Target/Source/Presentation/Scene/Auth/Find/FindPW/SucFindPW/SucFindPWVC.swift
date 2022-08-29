//
//  SucFindPWVC.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import RxKeyboard
import Then
import ReactorKit

final class SucFindPWVC: BaseVC<SucFindPWReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let checkMarkImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle.fill")?.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
        $0.contentMode = .scaleAspectFit
    }
    private let successLabel = UILabel().then {
        $0.text = "비밀번호 재등록이 완료되었습니다."
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textAlignment = .center
    }
    private let moveTosSignInButton = NextButton(title: "로그인하기")
    
    // MARK: - UI
    override func addView() {
        view.addSubview(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.alignItems(.center).define { flex in
            flex.addItem(checkMarkImageView)
                .marginTop(15%)
                .width(56)
                .height(56)
            flex.addItem(successLabel)
                .marginTop(5)
                .width(100%)
            flex.addItem(moveTosSignInButton)
                .top(12%)
                .width(88)
                .height(36)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "비밀번호 찾기")
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SucFindPWReactor) {
        moveTosSignInButton.rx.tap
            .map{ _ in Reactor.Action.navToSignInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

//
//  SendCertVC.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Then
import FlexLayout
import PinLayout
import RxCocoa
import RxFlow
import RxSwift
import ReactorKit

final class SendCertVC: BaseVC<SendCertReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 3
        $0.textAlignment = .center
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    private let certTextField = SignUpTextField().then {
        $0.placeholder = "인증번호"
        $0.leftSpace(14)
    }
    private let nextButton = NextButton(title: "다음 단계")
    
    init(reactor: SendCertReactor?, email: String) {
        super.init(reactor: reactor)
        var description = NSMutableAttributedString(
            string: """
                회원가입 시 입력하신 이메일
                \(email) 로
                인증번호가 전송되었습니다.
            """)
        description.insetColorForText(textToFind: email, withColor: MOIZAAsset.moizaPrimaryBlue.color)
        descriptionLabel.attributedText = description
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            flex.addItem(descriptionLabel)
                .marginTop(84)
                .alignSelf(.center)
            flex.addItem(certTextField)
                .marginTop(96)
                .width(95%)
                .alignSelf(.center)
                .height(40)
            flex.addItem(nextButton)
                .marginTop(70)
                .width(88)
                .height(36)
                .alignSelf(.end)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "비밀번호 찾기")
        self.navigationItem.configBack()
    }
    override func darkConfigure() {
        [
            certTextField
        ].forEach{
            $0.backgroundColor = MOIZAAsset.moizaDark2.color
            $0.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SendCertReactor) {
        nextButton.rx.tap
            .map { _ in Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        certTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateCertNumber)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: SendCertReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isValid)
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.nextButton.isEnabled = item
                owner.nextButton.backgroundColor = item ? MOIZAAsset.moizaPrimaryBlue.color : MOIZAAsset.moizaSecondaryBlue.color
            })
    }
}

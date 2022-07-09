//
//  GraduateSuccessVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/09.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import RxCocoa

final class GraduateSuccessVC: baseVC<GraduateSuccessReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let paperPlaneImageView = UIImageView().then {
        $0.image = UIImage(systemName: "paperplane.fill")?.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
    }
    private let successLabel = UILabel().then {
        $0.text = "졸업 인증 신청이 완료되었습니다."
        $0.textAlignment = .center
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let descriptionLabel = UILabel().then {
        $0.text = "빠른 시일 내 확인 후 승인하겠습니다.\n\n조금만 기다려주세요."
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let signInButton = NextButton(title: "홈으로 가기")
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.alignItems(.center).define { flex in
            flex.addItem(paperPlaneImageView).height(56).width(56).top(12.3%)
            flex.addItem(successLabel).width(100%).top(21%)
            flex.addItem(descriptionLabel).width(100%).top(28%)
            flex.addItem(signInButton).width(86).height(36).top(37%)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "졸업생 인증")
    }
    override func darkConfigure() {
        descriptionLabel.textColor = MOIZAAsset.moizaDark4.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: GraduateSuccessReactor) {
        signInButton.rx.tap
            .map { Reactor.Action.signInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

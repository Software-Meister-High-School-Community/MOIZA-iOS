//
//  GraduateAuthVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import RxCocoa
import FlexibleSteppedProgressBar

final class GraduateAuthVC: baseVC<GraduateAuthReactor> {
    // MARK: - Metric
    
    // MARK: - Properties
    private let progressBar = SignUpProgress().then {
        $0.numberOfPoints = 2
    }
    private let rootContainer = UIView()
    
    private let graduateImageView = UIImageView().then {
        $0.image = .init(systemName: "graduationcap.fill")?.tintColor(MOIZAAsset.moizaSecondaryBlue.color)
    }
    private let reasonLabel = UILabel().then {
        $0.text = "졸업생 인증을 하는 이유"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.medium, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let detailReasonLabbel = UILabel().then {
        $0.text = """
원활한 서비스 운영을 위하여 외부인의 사이트 이용을
제한하는 졸업생 인증 절차를 거치고 있습니다.
졸업생 가입자분들의 너른 양해 부탁드립니다.
"""
        $0.numberOfLines = 0
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.medium, size: 12)
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let warnLabel = UILabel().then {
        $0.text = "졸업생 인증을 하지 않으실 경우\n아래의 서비스 이용이 어렵습니다."
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let warnListLabel = UILabel().then {
        $0.text = "- 게시물 작성\n\n- 게시물 답글작성\n\n- 유저 팔로우"
        $0.numberOfLines = 0
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let firstDescriptionLabel = UILabel().then {
        $0.text = """
* 지금 인증을 하지 않으셔도, 추후 마이페이지 > 프로필 편집에서
  졸업생 인증이 가능합니다.
"""
        $0.numberOfLines = 0
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.medium, size: 12)
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let secondDescriptionLabel = UILabel().then {
        $0.text = "* 졸업생 인증 후에 승인이 완료되어야 서비스 이용이 가능합니다."
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.medium, size: 12)
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let nextButton = OnBoardingButton(text: "졸업생 인증하기",
                                              foregroundColor: MOIZAAsset.moizaGray1.color,
                                              backgroundColor: MOIZAAsset.moizaPrimaryBlue.color)
    private let signInButton = OnBoardingButton(text: "다음에 인증하고 로그인 하러가기",
                                               foregroundColor: MOIZAAsset.moizaGray4.color,
                                               backgroundColor: MOIZAAsset.moizaGray1.color).then {
        $0.layer.borderColor = MOIZAAsset.moizaGray4.color.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - UI
    override func setUp() {
        progressBar.delegate = self
    }
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(16).define { flex in
            flex.addItem(progressBar).top(12).height(10).marginHorizontal(4)
            flex.addItem(graduateImageView).width(36).height(24).marginTop(50)
            flex.addItem(reasonLabel).width(100%).marginTop(15)
            flex.addItem(detailReasonLabbel).width(100%).marginTop(10)
            flex.addItem(warnLabel).width(100%).marginTop(35)
            flex.addItem(warnListLabel).width(100%).marginTop(5)
            flex.addItem(firstDescriptionLabel).width(100%).marginTop(60)
            flex.addItem(secondDescriptionLabel).width(100%).marginTop(20)
            flex.addItem(nextButton).width(100%).height(50).marginTop(45)
            flex.addItem(signInButton).width(100%).height(50).marginTop(8)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "졸업생 인증")
        self.navigationItem.configBack()
    }
    override func darkConfigure() {
        [
            detailReasonLabbel, warnListLabel, firstDescriptionLabel, secondDescriptionLabel
        ].forEach {
            $0.textColor = MOIZAAsset.moizaDark4.color
        }
        nextButton.setTitleColor(MOIZAAsset.moizaConstGray1.color, for: .normal)
        signInButton.backgroundColor = MOIZAAsset.moizaDark2.color
        signInButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    // MARK: - Reactor
    override func bindView(reactor: GraduateAuthReactor) {
        nextButton.rx.tap
            .map { Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .map{ Reactor.Action.signInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension GraduateAuthVC: FlexibleSteppedProgressBarDelegate {
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

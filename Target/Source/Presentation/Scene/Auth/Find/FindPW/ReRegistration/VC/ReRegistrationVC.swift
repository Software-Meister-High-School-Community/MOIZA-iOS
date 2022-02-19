//
//  ReRegistrationVC.swift
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
import Hero

final class ReRegistrationVC: baseVC<ReRegistrationReactor> {
    // MARK: - Metric
    enum Metric {
        static let spacingMargin: CGFloat = 40
        static let labelHeight: CGFloat = 40
        static let height: CGFloat = 44
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.textColor = .label
        $0.text = "비밀번호 재등록"
    }
    private let newPwdTextField = SignUpTextField().then {
        $0.placeholder = "새 비밀번호"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.leftSpace(14)
    }
    private let newPwdVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    private let pwdHelperLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 11)
        $0.text = "8~16자 영문 대소문자, 숫자, 특수문자를 모두 조합하여 구성해주세요."
        $0.numberOfLines = 0
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    private let pwdCheckTextField = SignUpTextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.leftSpace(14)
    }
    private let pwdCheckVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
    }
    private let pwdCheckInvalidLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 11)
        $0.text = "비밀번호가 일치하지 않습니다. 다시 한번 입력해주세요."
    }
    private let nextButton = NextButton(title: "다음 단계")
    $0.textColor = .label
    $0.isHidden = true
    // MARK: - UI
    override func setUp() {
        view.addSubview(rootContainer )
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(16).define { flex in
            flex.addItem(titleLabel).marginTop(84)
            // MARK: NewPwd
            flex.addItem(newPwdTextField).marginTop(Metric.spacingMargin).width(100%).height(Metric.height)
        }
    }
}

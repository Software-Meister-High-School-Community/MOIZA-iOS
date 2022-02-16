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
import Hero
import RxCocoa
import RxFlow
import RxSwift
import ReactorKit

final class SendCertVC: baseVC<SendCertReactor> {
    // MARK: - Properties
    private let email: String = "adf"
    private let rootContainer = UIView()
    private let descriptionLabel = UILabel().then {
        $0.text = """
    회원가입 시 입력하신 이메일
    로
    인증번호가 전송되었습니다.
"""
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    
}

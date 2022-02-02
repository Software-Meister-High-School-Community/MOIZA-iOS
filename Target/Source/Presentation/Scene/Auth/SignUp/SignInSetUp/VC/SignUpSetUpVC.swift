//
//  SignUpSetUpVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxSwift
import RxCocoa
import PinLayout
import FlexibleSteppedProgressBar
import UIKit

final class SignUpSetUpVC: baseVC<SignUpSetUpReactor>{
    // MARK: - Properties
    private let progressBar = SignUpProgress().then {
        $0.currentIndex = 1
    }
    private let titleLabel = SubTitleLabel(title: "로그인 설정")
    private let idContainer = UIView()
    private let idLabel = UILabel()
    private let idCheckButton = UIButton()
    
    
    // MARK: - Init
    init(student: Student) {
        super.init()
        Observable.just(student)
            .map(Reactor.Action.`init`)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressBar.currentIndex = 2
    }
    
    // MARK: - UI
    override func setUp() {
        progressBar.delegate = self
    }
    override func addView() {
        view.addSubViews(progressBar, titleLabel)
    }
    override func setLayoutSubViews() {
        progressBar.pin.top(view.pin.safeArea.top + 12).horizontally(20).height(10)
        titleLabel.pin.below(of: progressBar, aligned: .left).pinEdges().marginTop(30).width(of: progressBar).sizeToFit(.width)
    }
    override func setLayout() {
        
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "회원가입")
    }
}

// MARK: - Extension
extension SignUpSetUpVC: FlexibleSteppedProgressBarDelegate{
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

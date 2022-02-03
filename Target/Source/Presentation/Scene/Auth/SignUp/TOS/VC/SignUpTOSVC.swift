//
//  SignUpTOSVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar
import Hero
import M13Checkbox
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class SignUpTOSVC: baseVC<SignUpTOSReactor>{
    // MARK: - Properties
    private let progressBar = SignUpProgress()
    private let titleLabel = SubTitleLabel(title: "약관동의")
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.text = "원활한 모이자 활동과 서비스 제공을 위해\n꼭 필요한 정보입니다."
        $0.numberOfLines = 0
    }
    private let subView = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
    }
    private let allAgreeButton = MoizaRadioButton()
    private let allAgreeLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        $0.text = "전체 약관 동의"
    }
    private let agreeContainer = UIView()
    private let separatorView = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray3.color
    }
    private let tosTableView = UITableView().then {
        $0.register(TOSCell.self, forCellReuseIdentifier: TOSCell.reusableID)
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.rowHeight = 50
        $0.isScrollEnabled = false
    }
    private let continueButton = UIButton().then {
        $0.setTitle("동의하고 계속", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray3.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    
    // MARK: - UI
    override func setUp() {
        bind(reactor: reactor)
        progressBar.delegate = self
    }
    override func addView() {
        view.addSubViews(progressBar, titleLabel, descriptionLabel, subView)
        subView.addSubViews(separatorView, tosTableView, continueButton, agreeContainer)
    }
    override func setLayoutSubViews() {
        progressBar.pin.top(view.pin.safeArea.top + 12).horizontally(20).height(10)
        titleLabel.pin.below(of: progressBar, aligned: .left).pinEdges().marginTop(30).width(of: progressBar).sizeToFit(.width)
        descriptionLabel.pin.below(of: titleLabel, aligned: .left).marginTop(30).width(of: progressBar).sizeToFit(.width)
        subView.pin.horizontally(view.pin.safeArea).bottom().height(50.86%)
        agreeContainer.pin.top(20).horizontally(20).height(30).width(100%)
        separatorView.pin.below(of: agreeContainer).height(1).horizontally(20).marginTop(5)
        continueButton.pin.bottom(12%).horizontally(20).height(52)
        tosTableView.pin.below(of: separatorView).above(of: continueButton).marginTop(5).horizontally(20).height(100)
        
        agreeContainer.flex.direction(.row).define { flex in
            flex.addItem(allAgreeButton).width(24).height(24)
            flex.addItem(allAgreeLabel).height(24).width(70%).marginLeft(8)
        }
        
        agreeContainer.flex.layout()
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "회원가입")
        
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindState(reactor: SignUpTOSReactor) {
        let shardState = reactor.state.share(replay: 3)

        let tosDS = RxTableViewSectionedReloadDataSource<TOSSection>{ [weak self] _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: TOSCell.reusableID, for: ip) as? TOSCell else { return .init() }
            cell.model = item
            cell.delegate = self
            return cell
        }

        shardState
            .map(\.tos)
            .map { [TOSSection.init(header: "", items: $0)] }
            .bind(to: tosTableView.rx.items(dataSource: tosDS))
            .disposed(by: disposeBag)

        shardState
            .map(\.tos)
            .map { $0.filter{ $0.isOn != true } }
            .map { if $0.isEmpty { return M13Checkbox.CheckState.checked }; return M13Checkbox.CheckState.unchecked }
            .bind(to: allAgreeButton.rx.checkState)
            .disposed(by: disposeBag)
        
        shardState
            .map(\.isAgreed)
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.continueButton.isEnabled = item
                owner.continueButton.setTitleColor(item ? MOIZAAsset.moizaGray6.color : MOIZAAsset.moizaGray3.color, for: .normal)
            })
            .disposed(by: disposeBag)
    }

    override func bindAction(reactor: SignUpTOSReactor) {
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: SignUpTOSReactor) {
        allAgreeButton.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .map { $0.0.allAgreeButton.checkState == .checked }
            .map { Reactor.Action.allAgreeButtonDidTap(isOn: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        continueButton.rx.tap
            .map { _ in Reactor.Action.continueButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension SignUpTOSVC: FlexibleSteppedProgressBarDelegate{
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

extension SignUpTOSVC: TOSCellDelegate{
    func checkButtonDidTap(isOn: Bool, type: TOSType) {
        Observable.just(type)
            .map(Reactor.Action.checkBoxDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    func detailButtonDidTap(type: TOSType) {
        
    }
}

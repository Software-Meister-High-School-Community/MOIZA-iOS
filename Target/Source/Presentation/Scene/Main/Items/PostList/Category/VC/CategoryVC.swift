//
//  CategoryVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import ViewAnimator

final class CategoryVC: baseVC<CategoryReactor> {
    // MARK: - Metric
    enum Metric {
        static let betweenSpacing: CGFloat = 11
        static let padding: CGFloat = 15
        static let bound = UIScreen.main.bounds
        static let defaultLen = (bound.width - 22 - padding * 2)/3
        static let twiceLen = defaultLen * 2 + betweenSpacing
    }
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    private let frontCategory = CategoryButton(major: .frontEnd,
                                             direction: .topRight,
                                             backgroundColor: MOIZAAsset.moizaPrimaryBlue.color,
                                             foregroundColor: .white)
    private let backCategory = CategoryButton(major: .backEnd,
                                            direction: .bottomLeft,
                                            backgroundColor: MOIZAAsset.moizaGray1.color,
                                            foregroundColor: MOIZAAsset.moizaPrimaryYellow.color)
    private let designCategory = CategoryButton(major: .design,
                                              direction: .bottomLeft,
                                              backgroundColor: MOIZAAsset.moizaGray1.color,
                                              foregroundColor: MOIZAAsset.moizaPrimaryBlue.color)
    private let iOSCategory = CategoryButton(major: .iOS,
                                           direction: .bottomRight,
                                           backgroundColor: MOIZAAsset.moizaPrimaryYellow.color,
                                           foregroundColor: .white)
    private let aOSCategory = CategoryButton(major: .aOS,
                                           direction: .topLeft,
                                           backgroundColor: MOIZAAsset.moizaPrimaryBlue.color,
                                           foregroundColor: .white)
    private let logoView = LogoView()
    private let gameCategory = CategoryButton(major: .game,
                                            direction: .centerRight,
                                            backgroundColor: MOIZAAsset.moizaGray1.color,
                                            foregroundColor: MOIZAAsset.moizaPrimaryYellow.color)
    private let securityCategory = CategoryButton(major: .security,
                                                direction: .bottomRight,
                                                backgroundColor: MOIZAAsset.moizaPrimaryBlue.color,
                                                foregroundColor: .white)
    private let embededCategory = CategoryButton(major: .embeded,
                                               direction: .bottomLeft,
                                               backgroundColor: MOIZAAsset.moizaGray1.color,
                                               foregroundColor: MOIZAAsset.moizaPrimaryYellow.color)
    private let aiCategory = CategoryButton(major: .ai,
                                          direction: .topRight,
                                          backgroundColor: MOIZAAsset.moizaPrimaryYellow.color,
                                          foregroundColor: .white)
    private let logoImage = UIBarButtonItem(image: MOIZAAsset.moizaLogo.image.downSample(size: .init(width: 35, height: 35)).withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(views: [
            frontCategory, backCategory, designCategory, iOSCategory, aOSCategory, securityCategory, gameCategory, embededCategory, aiCategory
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 30)
        ], duration: 0.5)
    }
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(frontCategory, backCategory, designCategory, iOSCategory, aOSCategory, logoView, gameCategory, securityCategory, embededCategory, aiCategory)
    }
    override func setLayoutSubViews() {
        scrollView.pin.all(view.pin.safeArea)
        scrollView.contentSize = .init(width: scrollView.bounds.width, height: scrollView.bounds.height*1.15)
        frontCategory.pin.topLeft(Metric.padding).size(Metric.defaultLen)
        backCategory.pin.topRight(Metric.padding).height(Metric.defaultLen).width(Metric.twiceLen)
        designCategory.pin.below(of: frontCategory, aligned: .left).marginTop(Metric.padding).width(Metric.defaultLen).height(Metric.twiceLen)
        iOSCategory.pin.below(of: backCategory, aligned: .left).marginTop(Metric.padding).size(Metric.defaultLen)
        aOSCategory.pin.after(of: iOSCategory, aligned: .top).marginLeft(Metric.padding).size(Metric.defaultLen)
        logoView.pin.below(of: iOSCategory, aligned: .left).marginTop(Metric.padding).size(Metric.defaultLen)
        gameCategory.pin.after(of: logoView, aligned: .top).marginLeft(Metric.padding).width(Metric.defaultLen).height(Metric.twiceLen)
        securityCategory.pin.below(of: designCategory, aligned: .left).marginTop(Metric.padding).width(Metric.twiceLen).height(Metric.defaultLen)
        embededCategory.pin.below(of: securityCategory, aligned: .left).marginTop(Metric.padding).size(Metric.defaultLen)
        aiCategory.pin.after(of: embededCategory, aligned: .top).marginLeft(Metric.padding).width(Metric.twiceLen).height(Metric.defaultLen)
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func configureNavigation() {
        self.navigationItem.setLeftBarButtonItems([logoImage], animated: true)
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
        [
            backCategory, designCategory, gameCategory, embededCategory
        ].forEach{ $0.backgroundColor = MOIZAAsset.moizaDark2.color }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: CategoryReactor) {
        frontCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.frontEnd) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        backCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.backEnd) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        designCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.design) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iOSCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.iOS) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        aOSCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.aOS) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        gameCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.game) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        securityCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.security) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        embededCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.embeded) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        aiCategory.rx.tap
            .map { Reactor.Action.categoryButtonDidTap(.ai) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

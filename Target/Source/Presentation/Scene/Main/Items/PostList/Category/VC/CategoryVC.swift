//
//  CategoryVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import SnapKit
import RxGesture

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
    private let contentView = UIView()
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
    private let logoImage = UIBarButtonItem(image: MOIZAAsset.moizaLogo.image.downSample(size: .init(width: 40, height: 40)).withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
    private let searchButton = UIBarButtonItem(image: .init(systemName: "magnifyingglass")?.downSample(size: .init(width: 15, height: 15)).tintColor(MOIZAAsset.moizaGray6.color), style: .plain, target: nil, action: nil)
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(frontCategory, backCategory, designCategory, iOSCategory, aOSCategory, logoView, gameCategory, securityCategory, embededCategory, aiCategory)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.centerX.top.bottom.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(bound.height*1.05).priority(.low)
        }
        frontCategory.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Metric.padding)
            $0.size.equalTo(Metric.defaultLen)
        }
        backCategory.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.defaultLen)
            $0.width.equalTo(Metric.twiceLen)
        }
        designCategory.snp.makeConstraints {
            $0.top.equalTo(frontCategory.snp.bottom).offset(Metric.betweenSpacing)
            $0.leading.equalToSuperview().offset(Metric.betweenSpacing)
            $0.width.equalTo(Metric.defaultLen)
            $0.height.equalTo(Metric.twiceLen)
        }
        iOSCategory.snp.makeConstraints {
            $0.top.equalTo(designCategory)
            $0.leading.equalTo(backCategory)
            $0.size.equalTo(Metric.defaultLen)
        }
        aOSCategory.snp.makeConstraints {
            $0.top.equalTo(iOSCategory)
            $0.leading.equalTo(iOSCategory.snp.trailing).offset(Metric.betweenSpacing)
            $0.trailing.equalTo(backCategory)
            $0.height.equalTo(Metric.defaultLen)
        }
        logoView.snp.makeConstraints {
            $0.top.equalTo(iOSCategory.snp.bottom).offset(Metric.betweenSpacing)
            $0.leading.equalTo(iOSCategory)
            $0.size.equalTo(Metric.defaultLen)
        }
        gameCategory.snp.makeConstraints {
            $0.top.equalTo(logoView)
            $0.trailing.equalTo(aOSCategory)
            $0.width.equalTo(Metric.defaultLen)
            $0.height.equalTo(Metric.twiceLen)
        }
        securityCategory.snp.makeConstraints {
            $0.top.equalTo(designCategory.snp.bottom).offset(Metric.betweenSpacing)
            $0.leading.equalTo(designCategory)
            $0.width.equalTo(Metric.twiceLen)
            $0.height.equalTo(Metric.defaultLen)
        }
        embededCategory.snp.makeConstraints {
            $0.top.equalTo(securityCategory.snp.bottom).offset(Metric.betweenSpacing)
            $0.leading.equalTo(securityCategory)
            $0.size.equalTo(Metric.defaultLen)
        }
        aiCategory.snp.makeConstraints {
            $0.top.equalTo(embededCategory)
            $0.trailing.equalTo(gameCategory)
            $0.width.equalTo(Metric.twiceLen)
            $0.height.equalTo(Metric.defaultLen)
        }
        
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func configureNavigation() {
        self.navigationItem.setLeftBarButtonItems([logoImage], animated: true)
        self.navigationItem.setRightBarButtonItems([searchButton], animated: true)
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
        
        searchButton.rx.tap
            .map { Reactor.Action.searchButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

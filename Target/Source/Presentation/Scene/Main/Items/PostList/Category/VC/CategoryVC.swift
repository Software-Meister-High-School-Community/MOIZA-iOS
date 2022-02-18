//
//  CategoryVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

final class CategoryVC: baseVC<CategoryReactor> {
    // MARK: - Metric
    enum Metric {
        static let spacing: CGFloat = 5.5
        static let betweenSpacing: CGFloat = 11
        static let bound = UIScreen.main.bounds
        static let defaultLen = (bound.width - 11 - 34)/3
    }
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let rootContainer = UIView()
    private let frontCategory = CategoryView(major: .frontEnd,
                                             direction: .topRight,
                                             backgroundColor: MOIZAAsset.moizaPrimaryBlue.color,
                                             foregroundColor: .white)
    private let backCategory = CategoryView(major: .backEnd,
                                            direction: .bottomLeft,
                                            backgroundColor: MOIZAAsset.moizaGray1.color,
                                            foregroundColor: MOIZAAsset.moizaPrimaryYellow.color)
    private let designCategory = CategoryView(major: .design,
                                              direction: .bottomLeft,
                                              backgroundColor: MOIZAAsset.moizaGray1.color,
                                              foregroundColor: MOIZAAsset.moizaPrimaryBlue.color)
    private let iOSCategory = CategoryView(major: .iOS,
                                           direction: .bottomRight,
                                           backgroundColor: MOIZAAsset.moizaPrimaryYellow.color,
                                           foregroundColor: .white)
    private let aOSCategory = CategoryView(major: .aOS,
                                           direction: .topLeft,
                                           backgroundColor: MOIZAAsset.moizaPrimaryBlue.color,
                                           foregroundColor: .white)
    private let logoView = IconCategoryView()
    private let gameCategory = CategoryView(major: .game,
                                            direction: .centerRight,
                                            backgroundColor: MOIZAAsset.moizaGray6.color,
                                            foregroundColor: MOIZAAsset.moizaPrimaryYellow.color)
    private let securityCategory = CategoryView(major: .security,
                                                direction: .bottomRight,
                                                backgroundColor: MOIZAAsset.moizaPrimaryBlue.color,
                                                foregroundColor: .white)
    private let embededCategory = CategoryView(major: .embeded,
                                               direction: .bottomLeft,
                                               backgroundColor: MOIZAAsset.moizaGray6.color,
                                               foregroundColor: MOIZAAsset.moizaPrimaryYellow.color)
    private let aiCategory = CategoryView(major: .ai,
                                          direction: .topRight,
                                          backgroundColor: MOIZAAsset.moizaPrimaryYellow.color,
                                          foregroundColor: .white)
    // MARK: - UI
    override func addView() {
        scrollView.addSubViews(rootContainer)
        view.addSubViews(scrollView)
    }
    override func setLayoutSubViews() {
        scrollView.pin.all()
        rootContainer.pin.top().pinEdges().horizontally(17)
        rootContainer.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = rootContainer.frame.size
    }
    override func setLayout() {
        rootContainer.flex.wrap(.wrap).direction(.row).justifyContent(.spaceBetween).define { flex in
            flex.addItem(frontCategory).size(Metric.defaultLen)
            flex.addItem(backCategory).height(Metric.defaultLen).width(Metric.defaultLen * 2 + Metric.betweenSpacing)
            flex.addItem(designCategory).height(Metric.defaultLen + Metric.defaultLen * 2 + Metric.betweenSpacing)
            flex.addItem(iOSCategory).size(Metric.defaultLen)
            flex.addItem(aOSCategory).size(Metric.defaultLen)
            flex.addItem(logoView).size(Metric.defaultLen)
            flex.addItem(gameCategory).width(Metric.defaultLen).height(Metric.defaultLen * 2 + Metric.betweenSpacing)
            flex.addItem(securityCategory).width(Metric.defaultLen * 2 + Metric.betweenSpacing).height(Metric.defaultLen)
            flex.addItem(embededCategory).size(Metric.defaultLen)
            flex.addItem(aiCategory).width(Metric.defaultLen * 2 + Metric.betweenSpacing).height(Metric.defaultLen)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
}

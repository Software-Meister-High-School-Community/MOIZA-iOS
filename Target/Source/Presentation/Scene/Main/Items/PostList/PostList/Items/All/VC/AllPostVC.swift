//
//  AllPostVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/20.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

final class AllPostVC: baseVC<PostListReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 200, height: 150)
        $0.showsHorizontalScrollIndicator = false
        $0.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.reusableID)
        $0.collectionViewLayout = layout
    }
    
    // MARK: - UI
    override func addView() {
        rootContainer.addSubViews(scrollView)
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        scrollView.pin.all()
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(recommendCollectionView).marginHorizontal(10).paddingTop(10).height(200)
            
        }
    }
    override func configureVC() {
        view.backgroundColor = .systemBlue
    }
    
    // MARK: - Reactor
}

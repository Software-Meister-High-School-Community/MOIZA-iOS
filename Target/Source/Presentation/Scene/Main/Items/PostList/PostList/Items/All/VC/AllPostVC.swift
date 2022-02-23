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
import RxSwift
import RxDataSources

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
        $0.backgroundColor = .clear
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
            flex.addItem(recommendCollectionView).marginHorizontal(10).top(20).height(200)
            
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: PostListReactor) {
        self.rx.viewDidLoad
            .map{ Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: PostListReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let recommendDS = RxCollectionViewSectionedReloadDataSource<RecommendSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: RecommendCell.reusableID, for: ip) as? RecommendCell else { return .init() }
            cell.model = item
            cell.backgroundColor = (ip.row+1)%2 == 0 ? MOIZAAsset.moizaPrimaryYellow.color : MOIZAAsset.moizaPrimaryBlue.color
            return cell
        }
        
        sharedState
            .map(\.recommendItem)
            .map { [RecommendSection.init(header: "", items: $0)] }
            .bind(to: recommendCollectionView.rx.items(dataSource: recommendDS))
            .disposed(by: disposeBag)
    }
}

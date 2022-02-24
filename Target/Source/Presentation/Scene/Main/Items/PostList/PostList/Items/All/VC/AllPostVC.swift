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
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 200, height: 150)
        $0.showsHorizontalScrollIndicator = false
        $0.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.reusableID)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
    private let headerLabel = UILabel().then {
        $0.text = "모든 게시물"
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 18)
    }
    private let sortButton = UIButton().then {
        $0.setTitle("정렬", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.setImage(MOIZAAsset.moizaFunnel.image.tintColor(MOIZAAsset.moizaConstGray3.color), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 1
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = MOIZAAsset.moizaGray1.color
            config.contentInsets = .init(top: 7, leading: 15, bottom: 7, trailing: 15)
            config.imagePadding = 5
            $0.configuration = config
        } else {
            $0.contentEdgeInsets = .init(top: 7, left: 15, bottom: 7, right: 15)
            $0.setBackgroundColor(MOIZAAsset.moizaGray1.color, for: .normal)
        }
    }
    private let postListTableView = UITableView().then {
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reusableID)
        $0.rowHeight = 60
        $0.separatorStyle = .none
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(recommendCollectionView).marginHorizontal(10).top(20).height(200)
            flex.addItem().direction(.row).paddingTop(30).marginHorizontal(17).define { flex in
                flex.addItem(headerLabel).grow(1)
                flex.addItem(sortButton).alignSelf(.end)
            }
            flex.addItem(postListTableView).grow(1).bottom(0).marginHorizontal(17).marginTop(25)
        }
        
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
        sortButton.setTitleColor(MOIZAAsset.moizaDark5.color, for: .normal)
        sortButton.layer.borderColor = UIColor.clear.cgColor
        if #available(iOS 15.0, *) {
            sortButton.configuration?.baseBackgroundColor = MOIZAAsset.moizaDark3.color
        } else {
            sortButton.setBackgroundColor(MOIZAAsset.moizaDark3.color, for: .normal)
        }
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: PostListReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.rx.viewWillAppear.do(onNext: { _ in UserDefaultsLocal.shared.post = .all } )
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindState(reactor: PostListReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let recommendDS = RxCollectionViewSectionedReloadDataSource<RecommendSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: RecommendCell.reusableID, for: ip) as? RecommendCell else { return .init() }
            cell.model = item
            cell.backgroundColor = (ip.row+1)%2 == 0 ? MOIZAAsset.moizaPrimaryYellow.color : MOIZAAsset.moizaPrimaryBlue.color
            return cell
        }
        
        let postDS = RxTableViewSectionedReloadDataSource<PostSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: PostCell.reusableID) as? PostCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.recommendItems)
            .map { [RecommendSection.init(header: "", items: $0)] }
            .bind(to: recommendCollectionView.rx.items(dataSource: recommendDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.postItems)
            .map { [PostSection.init(header: "", items: $0)] }
            .bind(to: postListTableView.rx.items(dataSource: postDS))
            .disposed(by: disposeBag)
        
    }
}

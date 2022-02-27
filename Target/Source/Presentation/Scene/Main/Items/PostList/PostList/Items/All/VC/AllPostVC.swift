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
    private let headerContainer = UIView()
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
    private let sortButton = SortButton()
    private let postListTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reusableID)
        $0.rowHeight = 60
        $0.separatorStyle = .none
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - UI
    override func setUp() {
        postListTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(rootContainer)
        headerContainer.addSubViews(recommendCollectionView, headerLabel, sortButton)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
        
        headerContainer.pin.width(bound.width-34).height(300)
        recommendCollectionView.pin.pinEdges().horizontally(10).marginTop(20).height(200)
        headerLabel.pin.topLeft(to: recommendCollectionView.anchor.bottomLeft).marginTop(30).sizeToFit()
        sortButton.pin.topRight(to: recommendCollectionView.anchor.bottomRight).marginTop(30).sizeToFit()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(postListTableView).grow(1).bottom(0).marginHorizontal(17)
        }
        
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
        postListTableView.backgroundColor = MOIZAAsset.moizaDark1.color
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

// MARK: - Extension
extension AllPostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerContainer
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerContainer.frame.height
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight: CGFloat = headerContainer.frame.height
        if scrollView.contentOffset.y <= headerHeight, scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = .init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        } else if scrollView.contentOffset.y >= headerHeight {
            scrollView.contentInset = .init(top: -headerHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

//
//  FollowerVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/03/02.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Hero
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageFollowerVC: baseVC<MyPageFollowReactor>{
    
    private let mainContainer = UIView()
    private let searchBar = UISearchBar().then{
        $0.searchBarStyle = .minimal
        $0.layer.cornerRadius = 5
    }
    override func setUp() {
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    override func addView() {
        view.addSubViews(mainContainer)
    }
    override func setLayoutSubViews() {
        mainContainer.pin.all(view.pin.safeArea)
        mainContainer.flex.layout()
    }
    override func setLayout() {
        mainContainer.flex.horizontally(16).define { flex in
            flex.addItem(searchBar).height(35).width(92%).marginTop(14)
        }
    }
}

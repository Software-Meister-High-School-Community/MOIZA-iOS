//
//  MyPageFollowVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/23.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Hero
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageFollowVC: baseVC<MyPageFollowReactor>{

    override func configureNavigation() {
        self.navigationItem.setTitle(title: "최형우")
        self.navigationItem.configBack()
    }
}

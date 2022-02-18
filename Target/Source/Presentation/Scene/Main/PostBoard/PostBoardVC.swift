//
//  PostBoardVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import Hero
import M13Checkbox
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class PostBoardVC: baseVC<PostBoardReactor>{
    
    private let mainContainer = UIView()
    private let numberOfDraftsButton = UIButton().then{
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 0.5
        $0.setTitle("임시저장된 글", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.layer.borderColor = MOIZAAsset.moizaGray4.color.cgColor
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    private let divisionLine = DivisionLine()
    private let numberOfDraftsLabel = UILabel().then{
        $0.text = ""
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    
    private let mainView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 13
    }
    
    private let postTypeView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 10
    }
    
    private let privacySettingView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 18
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray3.color
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "게시물 작성")
        self.navigationItem.configBack()
    }
}

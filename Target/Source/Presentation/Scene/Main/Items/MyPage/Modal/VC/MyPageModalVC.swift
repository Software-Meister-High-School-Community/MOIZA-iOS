//
//  MyPageModalVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/22.
//  Copyright © 2022 com.connect. All rights reserved.
//
import UIKit
import RxViewController
import PanModal

final class MyPageModalVC: baseVC<MyPageModalReactor>{
    func viewDidLoad() {
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
}
    
extension MyPageModalVC: PanModalPresentable{
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight{
        return .contentHeight(578)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(50)
    }
    var panModalBackgroundColor: UIColor{
        return UIColor.black.withAlphaComponent(0.4)
    }
    var anchorModalToLongForm: Bool {
        return false
    }
    var showDragIndicator: Bool {
        return true
    }
    var isUserInteractionEnabled: Bool {
        return true
    }
}

//
//  MyPageModalVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/22.
//  Copyright © 2022 com.connect. All rights reserved.
//

import PanModal

final class MyPageModalVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
}
    
extension MyPageModalVC: PanModalPresentable{
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight{
        return .contentHeight(528)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(400)
    }
    var panModalBackgroundColor: UIColor{
        return UIColor.black.withAlphaComponent(0.2)
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
    func configureVC(){
        
    }
}

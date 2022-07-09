//
//  DivisionLine.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/12.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

final class DivisionLine: UIView{
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 13))
        self.backgroundColor = MOIZAAsset.moizaGray4.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

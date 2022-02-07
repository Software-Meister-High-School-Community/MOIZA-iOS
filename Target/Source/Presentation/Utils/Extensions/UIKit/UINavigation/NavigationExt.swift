//
//  NavigationExt.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

extension UINavigationItem{
    func setTitle(title: String){
        let lb = UILabel()
        lb.text = title
        lb.textColor = MOIZAAsset.moizaGray6.color
        lb.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        self.titleView = lb
    }
    func configAuthNavigation(title: String){
        self.setTitle(title: title)
        let symbol = UIBarButtonItem(image: MOIZAAsset.moizaSymbol.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.rightBarButtonItem = symbol
    }
    func configBack(){
        let back = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        back.tintColor = MOIZAAsset.moizaGray6.color
        self.backBarButtonItem = back
    }
}

//
//  UIStackViewExt.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

extension UIStackView{
    func addArrangeSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

//
//  Reusable.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/27.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable{
    static var reusableID: String { get }
}
extension ReuseIdentifiable{
    static var reusableID: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}

//
//  PostType.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Moya
import Foundation
import UIKit

enum PostType: String, Codable{
    case question = "질문"
    case normal = "일반"
    
    var image: UIImage{
        switch self{
        case .question:
            return UIImage(systemName: "questionmark.circle.fill")!
        case .normal:
            return UIImage(systemName: "book.fill")!
        }
    }
}

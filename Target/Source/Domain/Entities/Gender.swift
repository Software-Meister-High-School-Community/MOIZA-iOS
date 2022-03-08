//
//  Gender.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

enum Gender: String, Codable{
    case male = "MALE"
    case female = "FEMALE"
}

extension Gender {
    var display: String {
        switch self {
        case .male: return "남"
        case .female: return "여"
        }
    }
}

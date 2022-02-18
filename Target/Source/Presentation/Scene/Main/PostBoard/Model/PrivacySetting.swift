//
//  PrivacySetting.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

enum PrivacySetting: String, Codable{
    case everyone = "전체공개"
    case studentOnly = "재학생만 공개"
    case graduateOnly = "졸업생만 공개"
}

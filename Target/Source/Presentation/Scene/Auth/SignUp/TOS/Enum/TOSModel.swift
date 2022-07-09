//
//  TOSModel.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/27.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Differentiator

struct TOSModel: Equatable{
    let type: TOSType
    let isOn: Bool
}

extension TOSModel: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}

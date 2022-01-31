//
//  GenderSection.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxDataSources

struct GenderSection{
    let header: String
    var items: [Gender]
}

extension GenderSection: SectionModelType{
    typealias Item = Gender
    init(original: GenderSection, items: [Gender]) {
        self = original
        self.items = items
    }
}

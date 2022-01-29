//
//  TOSSection.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxDataSources

struct TOSSection{
    let header: String
    var items: [TOSModel]
}

extension TOSSection: SectionModelType{
    typealias Item = TOSModel
    init(original: TOSSection, items: [TOSModel]) {
        self = original
        self.items = items
    }
}

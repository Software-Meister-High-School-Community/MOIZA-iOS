//
//  SchoolSection.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxDataSources

struct SchoolSection{
    let header: String
    var items: [School]
}

extension SchoolSection: SectionModelType{
    typealias Item = School
    init(original: SchoolSection, items: [School]) {
        self = original
        self.items = items
    }
}

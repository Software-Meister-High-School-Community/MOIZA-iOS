//
//  StepExt.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow

extension Step{
    var asMoizaStep: MoizaStep? {
        return self as? MoizaStep
    }
}

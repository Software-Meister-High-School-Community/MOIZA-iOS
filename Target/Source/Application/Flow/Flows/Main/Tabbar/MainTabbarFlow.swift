//
//  MainTabbarFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/10.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow

final class MainTabbarFlow: Flow{
    // MARK: - Properties
    enum TabIndex: Int {
        case home = 0
        case postList
        case alarm
        case myPage
    }
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC = MainTabbarVC()
    
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
            
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainTabbarFlow{
    
}

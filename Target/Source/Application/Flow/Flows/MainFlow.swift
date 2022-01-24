//
//  MainVC.swift
//  TopTabbarTest
//
//  Created by baegteun on 2021/12/02.
//  Copyright © 2021 baek. All rights reserved.
//

import UIKit
import RxFlow

final class MainFlow: Flow{
    var root: Presentable{
        return self.rootVC
    }
    
    enum TabIndex: Int{
        case home = 0
        case middle = 1
        case end = 2
    }
    
    let rootVC: UITabBarController = .init()
    // Flows
    
    init(){
        // Flows init
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        
        switch step{
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainFlow{
    
}

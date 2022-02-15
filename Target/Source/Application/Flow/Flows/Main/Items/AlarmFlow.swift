//
//  AlarmFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/10.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import RxRelay

struct AlarmStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MoizaStep.alarmIsRequired
    }
}

final class AlarmFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var vc: AlarmVC
    @Inject var stepper: AlarmStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .alarmIsRequired:
            return coordinateToAlarm()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension AlarmFlow{
    func coordinateToAlarm() -> FlowContributors {
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
}

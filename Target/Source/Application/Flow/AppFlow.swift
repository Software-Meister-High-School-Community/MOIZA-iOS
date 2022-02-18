//
//  AppFlow.swift
//
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow
import RxRelay
import RxSwift

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        Observable.just(MoizaStep.onBoardingIsRequired)
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}

final class AppFlow: Flow{
    
    // MARK: - Properties
    var root: Presentable{
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    // MARK: - Init
    
    init(
        with window: UIWindow
    ){
        self.rootWindow = window
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .onBoardingIsRequired:
            return coordinateToOnBoarding()
        case .mainTabbarIsRequired:
            return coordinateToMainTabbar()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension AppFlow{
    func coordinateToOnBoarding() -> FlowContributors {
        @Inject var flow: OnBoardingFlow
        
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: flow.stepper))
    }
    func coordinateToMainTabbar() -> FlowContributors {
        @Inject var flow: MainTabbarFlow
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow,
                                                 withNextStepper: OneStepper(withSingleStep: MoizaStep.onBoardingIsRequired))) // TODO: Main Tabbar Step
    }
}


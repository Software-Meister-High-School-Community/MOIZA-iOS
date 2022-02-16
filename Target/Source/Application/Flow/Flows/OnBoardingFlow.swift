//
//  OnBoardingFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import RxRelay
import Hero
import Then
import ReactorKit

struct OnBoardingStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MoizaStep.onBoardingIsRequired
    }
}

final class OnBoardingFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var vc: OnBoardingVC
    @Inject var stepper: OnBoardingStepper
    private let rootVC = UINavigationController().then {
        $0.hero.isEnabled = true
    }
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .signInIsRequired:
            return navigateToFindID()
        case .certIsRequired:
            return navigateToCert()
        case .successFindIDRequired:
            return navigateTpSucFindId()
        case .onBoardingIsRequired:
            return coordinateToOnBoarding()
        case .signUpIsRequired:
            return navigateToSignUpTOS()
        case .signUpInformationIsRequired:
            return navigateToSignUpInfo()
        case let .signUpLoginSetupIsRequired(student):
            return navigateToSignUpSetUp(student: student)
        case .signUpSuccessIsRequired:
            return navigateToSignUpSuccess()
        case .signUpIsCompleted:
            return navigateToRoot()
        case .findingPasswordIsRequired:
            return navigateToCheckId()
        case .sendCertRequired:
            return navigateToSendCert()
            
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension OnBoardingFlow{
    func navigateToSendCert() -> FlowContributors {
        @Inject var vc: SendCertVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToCheckId() -> FlowContributors {
        @Inject var vc: CheckIDVC
        self.rootVC.pushViewController(vc, animated: true)
        return  .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateTpSucFindId() -> FlowContributors {
        @Inject var vc: SucFindIDVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToCert() -> FlowContributors{
        @Inject var vc: CertEmailVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToFindID() -> FlowContributors{
        @Inject var vc: FindIDVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func coordinateToOnBoarding() -> FlowContributors{
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToSignUpTOS() -> FlowContributors{
        @Inject var vc: SignUpTOSVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToSignUpInfo() -> FlowContributors{
        @Inject var vc: SignUpInfoVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToSignUpSetUp(student: Student) -> FlowContributors{
        let reactor = SignUpSetUpReactor(student: student)
        let vc = SignUpSetUpVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToSignUpSuccess() -> FlowContributors {
        @Inject var vc: SignUpSuccessVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToRoot() -> FlowContributors {
        self.rootVC.popToRootViewController(animated: true)
        return .none
    }
}

//
//  OnBoardingFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import RxRelay
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
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .certIsRequired:
            return navigateToCert()
        case .findingIDIsRequired:
            return navigateToFindID()
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
        case .signUpIsCompleted, .signUpGraduateAuthIsCompleted, .findingPWIsCompleted:
            return navigateToRoot()
        case .signInIsRequired:
            return navigateToSignIn()
        case .signUpGraduateAuthIsRequired:
            return navigateToGraduateAuth()
        case .signUpGraduateAuthFileIsRequired:
            return navigateToGraduateFile()
        case .dismiss:
            return presentToDismiss()
        case let .alert(title, message):
            return presentToAlert(title: title, message: message)
        case .signUpGraduateAuthSuccessIsRequired:
            return navigateToGraduateSuccess()
        case .mainTabbarIsRequired:
            return .end(forwardToParentFlowWithStep: MoizaStep.mainTabbarIsRequired)
        case .findingPasswordIsRequired:
            return navigateToCheckId()
        case .sendCertRequired:
            return navigateToSendCert()
        case .reRegistorRequired:
            return navigateToReRegistration()
        case .successFindPWRequired:
            return navigateToSucFindPW()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension OnBoardingFlow{
    func navigateToSucFindPW() -> FlowContributors {
        @Inject var vc: SucFindPWVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToReRegistration() -> FlowContributors {
        @Inject var vc: NewPasswordVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToSendCert() -> FlowContributors {
        let vc = AppDelegate.container.resolve(SendCertVC.self, argument: "ksemms20@dgsw.hs.kr")!
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
    func navigateToSignIn() -> FlowContributors{
        @Inject var vc: SignInVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func presentToDismiss() -> FlowContributors {
        self.rootVC.dismiss(animated: true, completion: nil)
        return .none
    }
    func navigateToGraduateAuth() -> FlowContributors {
        @Inject var vc: GraduateAuthVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToGraduateFile() -> FlowContributors {
        @Inject var vc: GraduateFileVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func presentToAlert(title: String?, message: String?) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.rootVC.present(alert, animated: true, completion: nil)
        return .none
    }
    func navigateToGraduateSuccess() -> FlowContributors {
        @Inject var vc: GraduateSuccessVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
}

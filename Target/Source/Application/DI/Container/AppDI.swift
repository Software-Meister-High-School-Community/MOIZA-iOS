//
//  AppDI.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

extension Container{
    func registerDependencies(){
        registerVC()
        registerReactor()
        registerStepper()
        registerFlow()
        registerRepositories()
        registerUseCases()
    }
    
    // MARK: - View
    private func registerVC(){
        register(OnBoardingVC.self) { r in
            return OnBoardingVC(reactor: r.resolve(OnBoardingReactor.self))
        }
        register(SignUpTOSVC.self) { r in
            return SignUpTOSVC(reactor: r.resolve(SignUpTOSReactor.self))
        }
        register(SignUpInfoVC.self) { r in
            return SignUpInfoVC(reactor: r.resolve(SignUpInfoReactor.self))
        }
        register(SignUpSuccessVC.self) { r in
            return SignUpSuccessVC(reactor: r.resolve(SignUpSuccessReactor.self))
        }
        register(FindIDVC.self) { r in
            return FindIDVC(reactor: r.resolve(FindIDReactor.self))
        }
        register(CertEmailVC.self) { r in
            return CertEmailVC(reactor: r.resolve(CertEmailReactor.self))
        }
        register(SucFindIDVC.self) { r in
            return SucFindIDVC(reactor: r.resolve(SucFindIDReactor.self))
        }
        register(CheckIDVC.self) { r in
            return CheckIDVC(reactor: r.resolve(CheckIDReactor.self))
        }
        register(SendCertVC.self) { r in
            return SendCertVC(reactor: r.resolve(SendCertReactor.self))
        }
        register(ReRegistrationVC.self) { r in
            return ReRegistrationVC(reactor: r.resolve(ReRegistrationReactor.self))
        }
        register(SucFindPWVC.self) { r in
            return SucFindPWVC(reactor: r.resolve(SucFindPWReactor.self))
        }
    }
    private func registerReactor(){
        autoregister(OnBoardingReactor.self, initializer: OnBoardingReactor.init)
        autoregister(SignUpTOSReactor.self, initializer: SignUpTOSReactor.init)
        autoregister(SignUpInfoReactor.self, initializer: SignUpInfoReactor.init)
        autoregister(SignUpSetUpReactor.self, initializer: SignUpSetUpReactor.init)
        autoregister(SignUpSuccessReactor.self, initializer: SignUpSuccessReactor.init)
        autoregister(FindIDReactor.self, initializer: FindIDReactor.init)
        autoregister(CertEmailReactor.self, initializer: CertEmailReactor.init)
        autoregister(SucFindIDReactor.self, initializer: SucFindIDReactor.init)
        autoregister(CheckIDReactor.self, initializer: CheckIDReactor.init)
        autoregister(SendCertReactor.self, initializer: SendCertReactor.init)
        autoregister(ReRegistrationReactor.self, initializer: ReRegistrationReactor.init)
        autoregister(SucFindPWReactor.self, initializer: SucFindPWReactor.init)
    }
    private func registerStepper(){
        autoregister(OnBoardingStepper.self, initializer: OnBoardingStepper.init)
    }
    private func registerFlow(){
        
    }
    
    // MARK: - Data
    private func registerRepositories(){
        
    }
    private func registerUseCases(){
        
    }
}

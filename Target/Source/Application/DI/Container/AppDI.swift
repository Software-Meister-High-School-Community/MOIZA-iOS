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
        register(GraduateAuthVC.self) { r in
            return GraduateAuthVC(reactor: r.resolve(GraduateAuthReactor.self))
        }
    }
    private func registerReactor(){
        autoregister(OnBoardingReactor.self, initializer: OnBoardingReactor.init)
        autoregister(SignUpTOSReactor.self, initializer: SignUpTOSReactor.init)
        autoregister(SignUpInfoReactor.self, initializer: SignUpInfoReactor.init)
        autoregister(SignUpSetUpReactor.self, initializer: SignUpSetUpReactor.init)
        autoregister(SignUpSuccessReactor.self, initializer: SignUpSuccessReactor.init)
        autoregister(GraduateAuthReactor.self, initializer: GraduateAuthReactor.init)
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

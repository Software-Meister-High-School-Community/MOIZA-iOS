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
        register(SignInVC.self) { r in
            return SignInVC(reactor: r.resolve(SignInReactor.self))
        register(GraduateAuthVC.self) { r in
            return GraduateAuthVC(reactor: r.resolve(GraduateAuthReactor.self))
        }
        register(GraduateFileVC.self) { r in
            return GraduateFileVC(reactor: r.resolve(GraduateFileReactor.self))
        }
        register(GraduateSuccessVC.self) { r in
            return GraduateSuccessVC(reactor: r.resolve(GraduateSuccessReactor.self))
        }
    }
    private func registerReactor(){
        autoregister(OnBoardingReactor.self, initializer: OnBoardingReactor.init)
        autoregister(SignUpTOSReactor.self, initializer: SignUpTOSReactor.init)
        autoregister(SignUpInfoReactor.self, initializer: SignUpInfoReactor.init)
        autoregister(SignUpSetUpReactor.self, initializer: SignUpSetUpReactor.init)
        autoregister(SignUpSuccessReactor.self, initializer: SignUpSuccessReactor.init)
        autoregister(SignInReactor.self, initializer: SignInReactor.init)
        autoregister(GraduateAuthReactor.self, initializer: GraduateAuthReactor.init)
        autoregister(GraduateFileReactor.self, initializer: GraduateFileReactor.init)
        autoregister(GraduateSuccessReactor.self, initializer: GraduateSuccessReactor.init)
    }
    private func registerStepper(){
        autoregister(OnBoardingStepper.self, initializer: OnBoardingStepper.init)
    }
    private func registerFlow(){
        autoregister(OnBoardingFlow.self, initializer: OnBoardingFlow.init)
        autoregister(HomeFlow.self, initializer: HomeFlow.init)
        autoregister(PostListFlow.self, initializer: PostListFlow.init)
        autoregister(AlarmFlow.self, initializer: AlarmFlow.init)
        autoregister(MyPageFlow.self, initializer: MyPageFlow.init)
        autoregister(MainTabbarFlow.self, initializer: MainTabbarFlow.init)
    }
    
    // MARK: - Data
    private func registerRepositories(){
        
    }
    private func registerUseCases(){
        
    }
}

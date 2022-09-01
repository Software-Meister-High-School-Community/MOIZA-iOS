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
        }
        register(GraduateAuthVC.self) { r in
            return GraduateAuthVC(reactor: r.resolve(GraduateAuthReactor.self))
        }
        register(GraduateFileVC.self) { r in
            return GraduateFileVC(reactor: r.resolve(GraduateFileReactor.self))
        }
        register(GraduateSuccessVC.self) { r in
            return GraduateSuccessVC(reactor: r.resolve(GraduateSuccessReactor.self))
        }
        register(AlarmVC.self) { r in
            return AlarmVC(reactor: r.resolve(AlarmReactor.self))
        }
        register(HomeVC.self) { r in
            return HomeVC(reactor: r.resolve(HomeReactor.self))
        }
        register(MyPageVC.self) { r in
            return MyPageVC(reactor: r.resolve(MyPageReactor.self))
        }
        register(CategoryVC.self) { r in
            return CategoryVC(reactor: r.resolve(CategoryReactor.self))
        }
        register(PostBoardVC.self) { r in
            return PostBoardVC(reactor: r.resolve(PostBoardReactor.self))
        }
        register(ModifyProfileVC.self) { r in
            return ModifyProfileVC(reactor: r.resolve(ModifyProfileReactor.self))
        }
        
        register(PostListTabVC.self) { r in
            let reactor = r.resolve(PostListReactor.self)
            let vc = PostListTabVC(reactor: reactor)
            vc.setViewControllers([
                AllPostVC(reactor: vc.reactor),
                QuestionPostVC(reactor: vc.reactor),
                NormalPostVC(reactor: vc.reactor)
            ])
            return vc
        }
        register(MyFollowTabVC.self) { r in
            let reactor = r.resolve(MyFollowReactor.self)
            let vc = MyFollowTabVC(reactor: reactor)
            vc.setViewControllers([
                MyPageFollowerVC(reactor: vc.reactor),
                MyPageFollowingVC(reactor: vc.reactor)
            ])
            return vc
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
        register(SendCertVC.self) { r, email in
            return SendCertVC(reactor: r.resolve(SendCertReactor.self), email: email)
        }
        register(NewPasswordVC.self) { r in
            return NewPasswordVC(reactor: r.resolve(NewPasswordReactor.self))
        }
        register(SucFindPWVC.self) { r in
            return SucFindPWVC(reactor: r.resolve(SucFindPWReactor.self))
        }
        register(IntroduceModifyVC.self) { r in
            return IntroduceModifyVC(reactor: r.resolve(IntroduceModifyReactor.self))
        }
        register(WebsiteModifyVC.self) { r in
            return WebsiteModifyVC(reactor: r.resolve(WebsiteModifyReactor.self))
        }
    }
    private func registerReactor(){
        // MARK: - Auth
        register(OnBoardingReactor.self) { r in
            return OnBoardingReactor()
        }
        autoregister(SignUpTOSReactor.self, initializer: SignUpTOSReactor.init)
        autoregister(SignUpInfoReactor.self, initializer: SignUpInfoReactor.init)
        autoregister(SignUpSetUpReactor.self, initializer: SignUpSetUpReactor.init)
        autoregister(SignUpSuccessReactor.self, initializer: SignUpSuccessReactor.init)
        autoregister(SignInReactor.self, initializer: SignInReactor.init)
        autoregister(GraduateAuthReactor.self, initializer: GraduateAuthReactor.init)
        autoregister(GraduateFileReactor.self, initializer: GraduateFileReactor.init)
        autoregister(GraduateSuccessReactor.self, initializer: GraduateSuccessReactor.init)
        autoregister(FindIDReactor.self, initializer: FindIDReactor.init)
        autoregister(CertEmailReactor.self, initializer: CertEmailReactor.init)
        autoregister(SucFindIDReactor.self, initializer: SucFindIDReactor.init)
        autoregister(CheckIDReactor.self, initializer: CheckIDReactor.init)
        autoregister(SendCertReactor.self, initializer: SendCertReactor.init)
        autoregister(NewPasswordReactor.self, initializer: NewPasswordReactor.init)
        autoregister(SucFindPWReactor.self, initializer: SucFindPWReactor.init)
        autoregister(ModifyProfileReactor.self, initializer: ModifyProfileReactor.init)
        autoregister(WebsiteModifyReactor.self, initializer: WebsiteModifyReactor.init)
        
        // MARK: - Tab
        autoregister(AlarmReactor.self, initializer: AlarmReactor.init)
        register(NoticeListReactor.self) { r in
            return NoticeListReactor()
        }
        autoregister(HomeReactor.self, initializer: HomeReactor.init)
        autoregister(MyPageReactor.self, initializer: MyPageReactor.init)
        autoregister(CategoryReactor.self, initializer: CategoryReactor.init)
        autoregister(PostBoardReactor.self, initializer: PostBoardReactor.init)
        
        autoregister(PostListReactor.self, initializer: PostListReactor.init)
        autoregister(MyFollowReactor.self, initializer: MyFollowReactor.init)
        autoregister(IntroduceModifyReactor.self, initializer: IntroduceModifyReactor.init)
    }
    private func registerStepper(){
        autoregister(OnBoardingStepper.self, initializer: OnBoardingStepper.init)
        autoregister(AlarmStepper.self, initializer: AlarmStepper.init)
        autoregister(HomeStepper.self, initializer: HomeStepper.init)
        autoregister(MyPageStepper.self, initializer: MyPageStepper.init)
        autoregister(PostListStepper.self, initializer: PostListStepper.init)
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

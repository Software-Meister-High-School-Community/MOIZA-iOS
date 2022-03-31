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
        register(MyPageModalVC.self) { r in
            return MyPageModalVC(reactor: r.resolve(MyPageModalReactor.self))
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
        register(FollowTabVC.self) { r in
            let reactor = r.resolve(MyPageFollowerReactor.self)
            let vc = FollowTabVC(reactor: reactor)
            vc.setViewControllers([
                MyPageFollowerVC(reactor: vc.reactor),
                MyPageFollowingVC(reactor: vc.reactor)
            ])
            return vc
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
        autoregister(AlarmReactor.self, initializer: AlarmReactor.init)
        autoregister(HomeReactor.self, initializer: HomeReactor.init)
        autoregister(MyPageReactor.self, initializer: MyPageReactor.init)
        autoregister(CategoryReactor.self, initializer: CategoryReactor.init)
        autoregister(PostBoardReactor.self, initializer: PostBoardReactor.init)
        autoregister(MyPageModalReactor.self, initializer: MyPageModalReactor.init)
        autoregister(PostListReactor.self, initializer: PostListReactor.init)
        autoregister(MyPageFollowerReactor.self, initializer: MyPageFollowerReactor.init)
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

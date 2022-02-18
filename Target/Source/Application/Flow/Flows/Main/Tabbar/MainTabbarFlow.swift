//
//  MainTabbarFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/10.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow

final class MainTabbarFlow: Flow{
    // MARK: - Properties
    enum TabIndex: Int {
        case home = 0
        case postList
        case alarm
        case myPage
    }
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC = MainTabbarVC()
    
    @Inject private var homeFlow: HomeFlow
    @Inject private var postListFlow: PostListFlow
    @Inject private var alarmFlow: AlarmFlow
    @Inject private var myPageFlow: MyPageFlow
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .mainTabbarIsRequired:
            return coordinateToMainTabbar()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainTabbarFlow{
    func coordinateToMainTabbar() -> FlowContributors {
        Flows.use(
            homeFlow, postListFlow, alarmFlow, myPageFlow,
            when: .created
        ) { [unowned self] (root1: UINavigationController,
                            root2: UINavigationController,
                            root3: UINavigationController,
                            root4: UINavigationController) in
            let homeImage = MOIZAAsset.moizaHome.image.tintColor(MOIZAAsset.moizaGray5.color)
            let postListImage = MOIZAAsset.moizaPost.image.tintColor(MOIZAAsset.moizaGray5.color)
            let alarmImage = MOIZAAsset.moizaAlarm.image.tintColor(MOIZAAsset.moizaGray5.color)
            let myPageImage = MOIZAAsset.moizaPerson.image.tintColor(MOIZAAsset.moizaGray5.color)
            
            let homeSelectedImage = MOIZAAsset.moizaHomeFill.image.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
            let postListSelectedImage = MOIZAAsset.moizaPostFill.image.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
            let alarmSelectedImage = MOIZAAsset.moizaAlarmFill.image.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
            let myPageSelectedImage = MOIZAAsset.moizaPersonFill.image.tintColor(MOIZAAsset.moizaPrimaryBlue.color)
            
            let homeItem = UITabBarItem(title: nil, image: homeImage, selectedImage: homeSelectedImage)
            let postListItem = UITabBarItem(title: nil, image: postListImage, selectedImage: postListSelectedImage)
            let alarmItem = UITabBarItem(title: nil, image: alarmImage, selectedImage: alarmSelectedImage)
            let myPageItem = UITabBarItem(title: nil, image: myPageImage, selectedImage: myPageSelectedImage)
            
            root1.tabBarItem = homeItem
            root2.tabBarItem = postListItem
            root3.tabBarItem = alarmItem
            root4.tabBarItem = myPageItem
            
            self.rootVC.setViewControllers([root1, root2, root3, root4], animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: postListFlow, withNextStepper: postListFlow.stepper),
            .contribute(withNextPresentable: alarmFlow, withNextStepper: alarmFlow.stepper),
            .contribute(withNextPresentable: myPageFlow, withNextStepper: myPageFlow.stepper)
        ])
    }
}

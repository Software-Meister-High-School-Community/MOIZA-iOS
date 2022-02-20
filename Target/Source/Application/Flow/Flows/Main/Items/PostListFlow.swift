//
//  PostListFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/10.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import RxRelay

struct PostListStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MoizaStep.categoryIsRequired
    }
}

final class PostListFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject var stepper: PostListStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .categoryIsRequired:
            return coordinateToCategorySelect()
        case let .postListIsRequired(category):
            return coordinateToPostList(category: category)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension PostListFlow{
    func coordinateToCategorySelect() -> FlowContributors {
        @Inject var vc: CategoryVC
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func coordinateToPostList(category: Major) -> FlowContributors {
        @Inject var vc: PostListTabVC
        vc.setViewControllers([
            AllPostVC(reactor: vc.reactor),
            QuestionPostVC(reactor: vc.reactor),
            NormalPostVC(reactor: vc.reactor)
        ])
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
}

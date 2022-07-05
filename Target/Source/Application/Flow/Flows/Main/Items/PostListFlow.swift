//
//  PostListFlow.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/10.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import RxRelay
import RxSwift
import PanModal

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
        case .postListIsRequired:
            return coordinateToPostList()
        case .majorSelectIsRequired:
            return presentToMajorSelect()
        case .dismiss:
            return dismissVC()
        case let .postDetailIsRequired(id):
            return navigateToDetailPost(feedId: id)
        case let .sortIsRequired(options, initial, onComplete):
            return presentToSort(options, initial: initial, onComplete: onComplete)
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
    func coordinateToPostList() -> FlowContributors {
        @Inject var vc: PostListTabVC
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func presentToMajorSelect() -> FlowContributors {
        let reactor = MajorModalReactor()
        let vc = MajorModalVC(reactor: reactor)
        self.rootVC.presentPanModal(vc)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func presentToSort(_ options: [SortOption], initial: (PostType, SortType), onComplete: @escaping ((PostType, SortType, Major) -> Void)) -> FlowContributors {
        let reactor = SortModalReactor(initial: initial, onComplete: onComplete)
        let vc = SortModalVC(options, reactor: reactor)
        self.rootVC.presentPanModal(vc)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func dismissVC() -> FlowContributors {
        self.rootVC.visibleViewController?.dismiss(animated: true, completion: nil)
        return .none
    }
    func navigateToDetailPost(feedId: Int) -> FlowContributors {
        let reactor = DetailPostReactor(feedId: feedId)
        let vc = DetailPostVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}

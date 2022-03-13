
import RxFlow
import RxRelay

struct MyPageStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MoizaStep.myPageIsRequired
    }
}

final class MyPageFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var vc: MyPageVC
    @Inject var stepper: MyPageStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .myPageIsRequired:
            return coordinateToMyPage()
        case .myPostListSortIsRequired:
            return navigateToMyPageModal()
        case .followerIsRequired:
            return coordinateToFollow()
        case .followingIsRequired:
            return coordinateToFollow()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MyPageFlow{
    func coordinateToMyPage() -> FlowContributors {
        @Inject var vc: MyPageVC
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToMyPageModal() -> FlowContributors {
        @Inject var vc: MyPageModalVC
        self.rootVC.presentPanModal(vc)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func coordinateToFollow() -> FlowContributors {
        @Inject var vc: FollowTabVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
}

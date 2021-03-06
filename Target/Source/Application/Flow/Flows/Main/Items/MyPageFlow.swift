
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
        case let .sortIsRequired(options, initial, onComplete):
            return presentToSort(options, initial: initial, onComplete: onComplete)
        case .followerIsRequired:
            return navigateToFollow()
        case .dismiss:
            return dismissVC()
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
    func presentToSort(_ options: [SortOption], initial: (PostType, SortType), onComplete: @escaping ((PostType, SortType, Major) -> Void)) -> FlowContributors {
        let reactor = SortModalReactor(initial: initial, onComplete: onComplete)
        let vc = SortModalVC([.major, .sortType], reactor: reactor)
        self.rootVC.visibleViewController?.presentPanModal(vc)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToFollow() -> FlowContributors {
        @Inject var vc: MyFollowTabVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func dismissVC() -> FlowContributors {
        self.rootVC.visibleViewController?.dismiss(animated: true, completion: nil)
        return .none
    }
}

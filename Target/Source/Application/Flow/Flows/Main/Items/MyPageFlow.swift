
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
        case .myPageModifyIsRequired:
            return coordinateToModify()
        case .myPageIntroduceModifyIsRequired:
            return coordinateToIntroduceModify()
        case .myPageWebsiteAddIsRequired:
            return coordinateToWebsiteModify()
        case let .alert(title, message, style, action):
            return presentToAlert(title: title, message: message, style: style, action: action)
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
    func coordinateToModify() -> FlowContributors {
        @Inject var vc: ModifyProfileVC
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func coordinateToIntroduceModify() -> FlowContributors {
        @Inject var vc: IntroduceModifyVC
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func coordinateToWebsiteModify() -> FlowContributors {
        @Inject var vc: WebsiteModifyVC
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func presentToAlert(title: String?, message: String?, style: UIAlertController.Style, action: [UIAlertAction]) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        action.forEach { alert.addAction($0) }
        if UIDevice.current.userInterfaceIdiom == .pad {
            guard let view = rootVC.visibleViewController?.view else { return .none }
            guard let popOver = alert.popoverPresentationController else { return .none }
            popOver.sourceView = view
            popOver.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popOver.permittedArrowDirections = []
        }
        self.rootVC.visibleViewController?.present(alert, animated: true)
        return .none
    }
}

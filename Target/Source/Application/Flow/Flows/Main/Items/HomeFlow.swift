
import RxFlow
import RxRelay

struct HomeStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MoizaStep.homeIsRequired
    }
}

final class HomeFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var vc: HomeVC
    @Inject var stepper: HomeStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMoizaStep else { return .none }
        switch step{
        case .homeIsRequired:
            return coordinateToHome()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension HomeFlow{
    func coordinateToHome() -> FlowContributors {
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
}

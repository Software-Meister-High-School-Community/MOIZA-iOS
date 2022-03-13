import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MajorModalReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case majorDidTap(Major)
        case closeButtonDidTap
    }
    enum Mutation {}
    struct State {}
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension MajorModalReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .majorDidTap(major):
            UserDefaultsLocal.shared.major = major
            steps.accept(MoizaStep.dismiss)
        case .closeButtonDidTap:
            steps.accept(MoizaStep.dismiss)
        }
        return .empty()
    }
}

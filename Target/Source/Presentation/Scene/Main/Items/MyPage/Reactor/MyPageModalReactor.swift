
import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MyPageModalReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case latestOrderButtonDidTap
        case likeOrderButtonDidTap
        case oldOrderButtonDidTap
        case lookUpButtonDidTap
        case initializationButtonDidTap
    }
    enum Mutation {
        
    }
    struct State {
       
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension MyPageModalReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .latestOrderButtonDidTap:
            return .empty()
        case .likeOrderButtonDidTap:
            return .empty()
        case .oldOrderButtonDidTap:
            return .empty()
        case .lookUpButtonDidTap:
            return .empty()
        case .initializationButtonDidTap:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension MyPageModalReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        return newState
    }
}

// MARK: - Method
private extension MyPageModalReactor {
    
}

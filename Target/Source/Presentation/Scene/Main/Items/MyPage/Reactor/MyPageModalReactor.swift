
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
        case orderButtonDidTap
        case initializationButtonDidTap
        case applyButtonDidTap
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
        case .orderButtonDidTap:
            return .empty()
        case .initializationButtonDidTap:
            return .empty()
        case .applyButtonDidTap:
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

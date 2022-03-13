import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class DetailPostReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        
    }
    enum Mutation {
        
    }
    struct State {
        
    }
    private let id: Int
    let initialState: State
    
    // MARK: - Init
    init(
        feedId: Int
    ) {
        self.id = feedId
        initialState = State()
    }
    
}

// MARK: - Mutate
extension DetailPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension DetailPostReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension DetailPostReactor {
    
}

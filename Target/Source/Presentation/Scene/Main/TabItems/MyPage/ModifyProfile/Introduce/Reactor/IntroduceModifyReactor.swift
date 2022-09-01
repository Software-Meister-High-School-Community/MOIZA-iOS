
import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class IntroduceModifyReactor: Reactor, Stepper{
    
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    
    // MARK: - Reactor
    enum Action {
        case updateIntroduce(String)
        case nextButtonDidTap
    }
    
    enum Mutation{
        case setIntroduce(String)
    }
    
    struct State{
        var introduce: String?
    }
    
    let initialState: State
    
    // MARK: - Init
    init(){
        initialState = State(introduce: "")
    }
}

// MARK: - Mutate
extension IntroduceModifyReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .updateIntroduce:
            steps.accept(MoizaStep.myPageIntroduceModifyIsRequired)
            return .empty()
        case .nextButtonDidTap:
            steps.accept(MoizaStep.myPageModifyIsRequired)
            return .empty()
        }
    }
}

extension IntroduceModifyReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation{
        case let .setIntroduce(introduce):
            newState.introduce = introduce
        }
        return newState
    }
}


import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class WebsiteModifyReactor: Reactor, Stepper{
    
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    
    // MARK: - Reactor
    enum Action {
        case updateWebsite(String)
        case nextButtonDidTap
    }
    
    enum Mutation{
        case setWebsite(String)
    }
    
    struct State{
        var website: String?
    }
    
    let initialState: State
    
    // MARK: - Init
    init(){
        initialState = State(website: "")
    }
}

// MARK: - Mutate
extension WebsiteModifyReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .updateWebsite:
            steps.accept(MoizaStep.myPageWebsiteAddIsRequired)
            return .empty()
        case .nextButtonDidTap:
            steps.accept(MoizaStep.myPageModifyIsRequired)
            return .empty()
        }
    }
}

extension WebsiteModifyReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation{
        case let .setWebsite(website):
            newState.website = website
        }
        return newState
    }
}

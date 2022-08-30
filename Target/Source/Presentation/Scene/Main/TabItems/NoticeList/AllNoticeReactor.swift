import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class NoticeListReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case setNoticeList([NoticeList])
    }
    struct State {
        var noticeList: [NoticeList]
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            noticeList: []
        )
    }
    
}

// MARK: - Mutate
extension NoticeListReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension NoticeListReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setNoticeList(list):
            newState.noticeList = list
        }
        
        return newState
    }
}

// MARK: - Method
private extension NoticeListReactor {
    func viewDidLoad() -> Observable<Mutation> {
        return .just(.setNoticeList([.dummy, .dummy, .dummy, .dummy]))
    }
}

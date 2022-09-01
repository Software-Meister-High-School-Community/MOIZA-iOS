import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class DetailNoticeReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case setNotice(Notice)
    }
    struct State {
        var notice: Notice?
    }
    let initialState: State
    private let noticeId: String
    
    // MARK: - Init
    init(noticeId: String) {
        self.noticeId = noticeId
        initialState = State()
    }
    
}

// MARK: - Mutate
extension DetailNoticeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension DetailNoticeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setNotice(notice):
            newState.notice = notice
        }
        
        return newState
    }
}

// MARK: - Method
private extension DetailNoticeReactor {
    func viewDidLoad() -> Observable<Mutation> {
        return .just(.setNotice(.dummy))
    }
}

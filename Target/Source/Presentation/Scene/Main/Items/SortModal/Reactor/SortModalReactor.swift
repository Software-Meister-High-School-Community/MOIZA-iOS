import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class SortModalReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case postTypeSegDidTap(PostType)
        case sortTypeSegDidTap(SortType)
        case majorPickerDidSet(Major)
        case applyButtonDidTap
    }
    enum Mutation {
        case setPostType(PostType)
        case setSortType(SortType)
        case setMajor(Major)
    }
    struct State {
        var postType: PostType
        var sortType: SortType
        var major: Major
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            postType: UserDefaultsLocal.shared.post,
            sortType: UserDefaultsLocal.shared.sort,
            major: UserDefaultsLocal.shared.major
        )
    }
    
}

// MARK: - Mutate
extension SortModalReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .postTypeSegDidTap(post):
            return .just(.setPostType(post))
        case let .sortTypeSegDidTap(sort):
            return .just(.setSortType(sort))
        case let .majorPickerDidSet(major):
            return .just(.setMajor(major))
        case .applyButtonDidTap:
            UserDefaultsLocal.shared.major = currentState.major
            UserDefaultsLocal.shared.post = currentState.postType
            UserDefaultsLocal.shared.sort = currentState.sortType
            print(currentState)
            steps.accept(MoizaStep.dismiss)
            return .empty()
        }
    }
}

// MARK: - Reduce
extension SortModalReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPostType(post):
            newState.postType = post
        case let .setSortType(sort):
            newState.sortType = sort
        case let .setMajor(major):
            newState.major = major
        }
        return newState
    }
}

// MARK: - Method
private extension SortModalReactor {
    
}

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
    private let onComplete: ((PostType, SortType, Major) -> Void)
    
    // MARK: - Init
    init(initial: (PostType, SortType), onComplete: @escaping ((PostType, SortType, Major) -> Void)) {
        initialState = State(
            postType: initial.0,
            sortType: initial.1,
            major: UserDefaultsLocal.shared.major
        )
        self.onComplete = onComplete
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
            onComplete(currentState.postType, currentState.sortType, currentState.major)
            UserDefaultsLocal.shared.major = currentState.major
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

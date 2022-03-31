
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
        case sortTypeSegDidTap(SortType)
        case majorPickerDidSet(Major)
        case applyButtonDidTap
    }
    enum Mutation {
        case setSortType(SortType)
        case setMajor(Major)
    }
    struct State {
        var sortType: SortType
        var major: Major
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            sortType: UserDefaultsLocal.shared.sort,
            major: UserDefaultsLocal.shared.major
        )
    }
    
}

// MARK: - Mutate
extension MyPageModalReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .sortTypeSegDidTap(sort):
            return .just(.setSortType(sort))
        case let .majorPickerDidSet(major):
            return .just(.setMajor(major))
        case .applyButtonDidTap:
            UserDefaultsLocal.shared.major = currentState.major
            UserDefaultsLocal.shared.sort = currentState.sortType
            print(currentState)
            steps.accept(MoizaStep.dismiss)
            return .empty()
        }
    }
}

// MARK: - Reduce
extension MyPageModalReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSortType(sort):
            newState.sortType = sort
        case let .setMajor(major):
            newState.major = major
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageModalReactor {
    
}

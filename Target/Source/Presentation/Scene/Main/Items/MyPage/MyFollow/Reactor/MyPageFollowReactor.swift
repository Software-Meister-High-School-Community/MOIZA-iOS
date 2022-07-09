
import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MyPageFollowReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    // MARK: - Reactor
    enum Action {
        case viewWillAppear
    }
    enum Mutation {
        case setFollowerList([FollowerUserList])
        case setFollowingList([FollowingUserList])
    }
    struct State {
        var FollowerItems: [FollowerUserList]
        var FollowingItems: [FollowingUserList]
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(FollowerItems: [], FollowingItems: [])
    }
    
}

// MARK: - Mutate
extension MyPageFollowReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return viewWillAppear()
        }
    }
}

// MARK: - Reduce
extension MyPageFollowReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setFollowerList(followers):
            newState.FollowerItems = followers
        case let .setFollowingList(followings):
            newState.FollowingItems = followings
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageFollowReactor {
    func viewWillAppear() -> Observable<Mutation>{
        let follower: [FollowerUserList] = [
            .dummy,
            .dummy,
            .dummy
        ]
        let following: [FollowingUserList] = [
            .dummy,
            .dummy,
            .dummy,
            .dummy,
            .dummy
        ]
        return .concat([
            .just(.setFollowerList(follower)),
            .just(.setFollowingList(following))
        ])
    }
}

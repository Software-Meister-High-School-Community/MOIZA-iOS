
import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MyFollowReactor: Reactor, Stepper {
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
        var followerItems: [FollowerUserList]
        var followingItems: [FollowingUserList]
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(followerItems: [], followingItems: [])
    }
    
}

// MARK: - Mutate
extension MyFollowReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return viewWillAppear()
        }
    }
}

// MARK: - Reduce
extension MyFollowReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setFollowerList(followers):
            newState.followerItems = followers
        case let .setFollowingList(followings):
            newState.followingItems = followings
        }
        return newState
    }
}

// MARK: - Method
private extension MyFollowReactor {
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

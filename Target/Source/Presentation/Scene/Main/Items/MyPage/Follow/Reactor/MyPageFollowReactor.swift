
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
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation {
        case setFollowerList([UserList])
        case updateFollowerList([UserList])
    }
    struct State {
        var FollowItems: [UserList]
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(FollowItems: [])
    }
    
}

// MARK: - Mutate
extension MyPageFollowReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return viewWillAppear()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
        }
    }
}

// MARK: - Reduce
extension MyPageFollowReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setFollowerList(followers):
            newState.FollowItems = followers
        case let .updateFollowerList(followers):
            newState.FollowItems.append(contentsOf: followers)
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageFollowReactor {
    func viewWillAppear() -> Observable<Mutation>{
        let follower: [UserList] = [
            .init(userId: 0, name: "최형우", profileImageURL: "https://avatars.githubusercontent.com/u/74440939?v=4", school: .gsm, userScope: .student, isFollow: .random()),
            .init(userId: 1, name: "김상은", profileImageURL: "https://avatars.githubusercontent.com/u/81676542?v=4", school: .dgsm, userScope: .student, isFollow: .random()),
            .init(userId: 2, name: "임준화", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .gsm, userScope: .user, isFollow: .random())
        ]
        return .concat([
            .just(.setFollowerList(follower))
        ])
    }
    func pagenation(
        contentHeight: CGFloat,
        contentOffsetY: CGFloat,
        scrollViewHeight: CGFloat
    ) -> Observable<Mutation> {
        let padding = contentHeight - contentOffsetY
        if padding < scrollViewHeight {
            self.page += 1
            return Observable.just([UserList(userId: currentState.FollowItems.count+1, name: "최형우", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .gsm, userScope: .user, isFollow: .random())])
                .map(Mutation.updateFollowerList)
        } else {
            return .empty()
        }
    }
}

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MyPageFollowingReactor: Reactor, Stepper {
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
        case setFollowingList([UserList])
        case updateFollowingList([UserList])
    }
    struct State {
        var FollowingItems: [UserList]
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(FollowingItems: [])
    }
    
}

// MARK: - Mutate
extension MyPageFollowingReactor {
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
extension MyPageFollowingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setFollowingList(followers):
            newState.FollowingItems = followers
        case let .updateFollowingList(followings):
            newState.FollowingItems.append(contentsOf: followings)
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageFollowingReactor {
    func viewWillAppear() -> Observable<Mutation>{
        let following: [UserList] = [
            .init(userID: 0, name: "최형우", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .gsm, userScope: .student, isFollow: .random()),
            .init(userID: 1, name: "김상은", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .dgsm, userScope: .student, isFollow: .random())
        ]
        return .concat([
            .just(.setFollowingList(following))
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
            return Observable.just([UserList(userID: currentState.FollowingItems.count+1, name: "최형우", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .gsm, userScope: .user, isFollow: .random())])
                .map(Mutation.updateFollowingList)
        } else {
            return .empty()
        }
    }
}

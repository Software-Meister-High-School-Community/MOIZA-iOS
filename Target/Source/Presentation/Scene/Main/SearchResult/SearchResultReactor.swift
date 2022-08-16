import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class SearchResultReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case postDidTap(String)
    }
    enum Mutation {
        case setKeyword(String)
        case setPosts([PostList])
        case setUsers([SearchUserList])
        case appendPosts([PostList])
    }
    struct State {
        var keyword: String
        var posts: [PostList]
        var users: [SearchUserList]
    }
    let initialState: State
    
    // MARK: - Init
    init(keyword: String) {
        initialState = State(
            keyword: keyword,
            posts: [],
            users: []
        )
    }
    
}

// MARK: - Mutate
extension SearchResultReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case let .postDidTap(id):
            steps.accept(MoizaStep.postDetailIsRequired(id))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension SearchResultReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setKeyword(keyword):
            newState.keyword = keyword
        case let .setPosts(posts):
            newState.posts = posts
        case let .setUsers(users):
            newState.users = users
        case let .appendPosts(posts):
            newState.posts.append(contentsOf: posts)
        }
        
        return newState
    }
}

// MARK: - Method
private extension SearchResultReactor {
    func viewDidLoad() -> Observable<Mutation> {
        return .concat([
            .just(.setPosts([.dummy, .dummy, .dummy])),
            .just(.setUsers([.dummy, .dummy, .dummy, .dummy])),
            .just(.setKeyword(initialState.keyword))
        ])
    }
}

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
        case sortButtonDidTap
        case setSorting(Major, PostType, SortType)
    }
    enum Mutation {
        case setKeyword(String)
        case setPosts([PostList])
        case setUsers([SearchUserList])
        case appendPosts([PostList])
        case setSorting(Major, PostType, SortType)
    }
    struct State {
        var keyword: String
        var posts: [PostList]
        var users: [SearchUserList]
        var major: Major
        var postType: PostType
        var sortType: SortType
    }
    let initialState: State
    
    // MARK: - Init
    init(keyword: String) {
        initialState = State(
            keyword: keyword,
            posts: [],
            users: [],
            major: UserDefaultsLocal.shared.major,
            postType: .all,
            sortType: .latest
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
        case .sortButtonDidTap:
            steps.accept(MoizaStep.sortIsRequired([.major, .postType, .sortType], initial: (PostType.all, SortType.latest), onComplete: { [weak self] post, sort, major in
                self?.action.onNext(.setSorting(major, post, sort))
            }))
        case let .setSorting(major, post, sort):
            return .just(.setSorting(major, post, sort))
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
        case let .setSorting(major, post, sort):
            newState.major = major
            newState.postType = post
            newState.sortType = sort
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

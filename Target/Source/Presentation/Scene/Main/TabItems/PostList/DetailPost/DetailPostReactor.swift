import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class DetailPostReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case reportMenuDidTap
        case updateMenuDidTap
        case deleteMenuDidTap
    }
    enum Mutation {
        case setComments([Comment])
        case setPost(Post)
    }
    struct State {
        var comments: [Comment]
        var post: Post?
    }
    private let id: Int
    let initialState: State
    
    // MARK: - Init
    init(
        feedId: Int
    ) {
        self.id = feedId
        initialState = State(
            comments: []
        )
    }
    
}

// MARK: - Mutate
extension DetailPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case .reportMenuDidTap:
            return reportMenuDidTap()
        case .updateMenuDidTap:
            return updateMenuDidTap()
        case .deleteMenuDidTap:
            return deleteMenuDidTap()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension DetailPostReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setComments(comments):
            newState.comments = comments
        case let .setPost(post):
            newState.post = post
        }
        
        return newState
    }
}

// MARK: - Method
private extension DetailPostReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let post = Post.dummy
        return .concat([
            .just(.setPost(post)),
            .just(.setComments(post.comments))
        ])
    }
    func reportMenuDidTap() -> Observable<Mutation> {
        
        return .empty()
    }
    func updateMenuDidTap() -> Observable<Mutation> {
        return .empty()
    }
    func deleteMenuDidTap() -> Observable<Mutation> {
        return .empty()
    }
}

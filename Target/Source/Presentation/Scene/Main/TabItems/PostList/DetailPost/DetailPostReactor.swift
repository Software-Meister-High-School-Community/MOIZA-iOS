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
    }
    enum Mutation {
        case setComments([Comment])
    }
    struct State {
        var comments: [Comment]
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
        }
        
        return newState
    }
}

// MARK: - Method
private extension DetailPostReactor {
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setComments([
            .init(id: 0,
                  author: .init(id: 0, profileImageUrl: "https://avatars.githubusercontent.com/u/14981341?s=48&v=4", name: "ASDF", schoolName: "ASDF", type: .student),
                  isMine: true,
                  isPinned: false,
                  createdAt: Date(),
                  content: "Content",
                  likeCount: 2,
                  imageUrls: [],
                  childComments: []
                 ),
            .init(id: 2,
                  author: .init(id: 0, profileImageUrl: "https://avatars.githubusercontent.com/u/14981341?s=48&v=4", name: "ASDF", schoolName: "ASDF", type: .student),
                  isMine: true,
                  isPinned: false,
                  createdAt: Date(),
                  content: "Content\n\ncon\nasdf\nasd",
                  likeCount: 2,
                  imageUrls: [],
                  childComments: []
                 ),
            .init(id: 0,
                  author: .init(id: 0, profileImageUrl: "https://avatars.githubusercontent.com/u/14981341?s=48&v=4", name: "ASDF", schoolName: "ASDF", type: .student),
                  isMine: true,
                  isPinned: false,
                  createdAt: Date(),
                  content: "Content",
                  likeCount: 2,
                  imageUrls: [],
                  childComments: []
                 )
        ]))
    }
}

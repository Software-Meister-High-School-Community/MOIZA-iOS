import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class SearchReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewWillAppear
        case recentSearchKeywordDidTap(keyword: String)
        case allRemoveButtonDidTap
        case recentSearchRemoveButtonDidTap(id: Int)
        case updateSearchTextField(String)
    }
    enum Mutation {
        case setRecentSearchList([RecentSearch])
        case removeRecentSearchById(Int)
        case setSearchText(String)
    }
    struct State {
        var recentSeachList: [RecentSearch]
        var searchText: String
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            recentSeachList: [],
            searchText: ""
        )
    }
    
}

// MARK: - Mutate
extension SearchReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return viewWillAppear()
        case .allRemoveButtonDidTap:
            return allRemoveButtonDidTap()
        case let .recentSearchRemoveButtonDidTap(id):
            return recentSearchRemoveButtonDidTap(id: id)
        case let .updateSearchTextField(text):
            return .just(.setSearchText(text))
        case let .recentSearchKeywordDidTap(keyword):
            return .just(.setSearchText(keyword))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension SearchReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setRecentSearchList(list):
            newState.recentSeachList = list
        case let .removeRecentSearchById(id):
            newState.recentSeachList.removeAll {
                $0.id == id
            }
        case let .setSearchText(text):
            newState.searchText = text
        }
        
        return newState
    }
}

// MARK: - Method
private extension SearchReactor {
    func viewWillAppear() -> Observable<Mutation> {
        let list: [RecentSearch] = [.dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy]
        return .just(.setRecentSearchList(list))
    }
    func allRemoveButtonDidTap() -> Observable<Mutation> {
        return .just(.setRecentSearchList([]))
    }
    func recentSearchRemoveButtonDidTap(id: Int) -> Observable<Mutation> {
        
        return .just(.removeRecentSearchById(id))
    }
}

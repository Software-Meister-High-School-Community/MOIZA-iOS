//
//  PostListReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/20.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Foundation

final class PostListReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    
    // MARK: - Reactor
    enum Action {
        case postDidTap(Int)
        case viewDidLoad
        case viewWillAppear
        case majorButtonDidTap
        case majorDidChange(Major)
        case reachedBottom(PostType)
        case sortButtonDidTap
        case sortOnComplete(PostType, SortType, Major)
        case searchButtonDidTap
    }
    enum Mutation {
        case setMajor(Major)
        case setSortOption(PostType, SortType, Major)
        case setRecommendPostList(type: PostType, [PostList])
        case setPostList(type: PostType, [PostList])
        case updatePostList(type: PostType, [PostList])
    }
    struct State {
        var major: Major
        var recommendItems: [PostType: [PostList]]
        var postItems: [PostType: [PostList]]
        var sortType: SortType
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            major: UserDefaultsLocal.shared.major,
            recommendItems: [:],
            postItems: [:],
            sortType: .latest
        )
    }
    
}

// MARK: - Mutate
extension PostListReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .majorDidChange(major):
            return .just(.setMajor(major))
        case .majorButtonDidTap:
            steps.accept(MoizaStep.majorSelectIsRequired)
        case .viewDidLoad:
            return viewDidLoad()
        case .sortButtonDidTap:
            steps.accept(MoizaStep.sortIsRequired(
                [.sortType],
                initial: (.all, currentState.sortType),
                onComplete: { [weak self] postType, sortType, major in
                self?.action.onNext(.sortOnComplete(postType, sortType, major))
            }))
        case .viewWillAppear:
            return viewWillAppear()
        case let .sortOnComplete(post, sort, major):
            return .just(.setSortOption(post, sort, major))
        case let .reachedBottom(postType):
            return reachedBottom(postType: postType)
        case let .postDidTap(id):
            steps.accept(MoizaStep.postDetailIsRequired(id))
        case .searchButtonDidTap:
            steps.accept(MoizaStep.searchIsRequired)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension PostListReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setMajor(major):
            newState.major = major
        case let .setSortOption(_, sort, _):
            newState.sortType = sort
        case let .setRecommendPostList(type, list):
            newState.recommendItems[type] = list
        case let .setPostList(type, list):
            newState.postItems[type] = list
        case let .updatePostList(type, list):
            newState.postItems[type]?.append(contentsOf: list)
        }
        
        return newState
    }
}

// MARK: - Method
private extension PostListReactor {
    func viewWillAppear() -> Observable<Mutation> {
        return .empty()
    }
    func viewDidLoad() -> Observable<Mutation> {
        return .concat([
            .just(.setRecommendPostList(type: .all, [.dummy, .dummy, .dummy, .dummy, .dummy])),
            .just(.setPostList(type: .all, [.dummy, .dummy, .dummy, .dummy, .dummy, .dummy]))
        ])
    }
    func reachedBottom(postType: PostType) -> Observable<Mutation> {
        return .just(.updatePostList(type: .all, [
            .dummy,
            .dummy,
            .dummy,
            .dummy,
            .dummy
        ]))
    }
}

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
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
        case sortButtonDidTap
    }
    enum Mutation {
        case setMajor(Major)
        case setRecommendPostList([PostList])
        case setPostList([PostList])
        case updatePostList([PostList])
    }
    struct State {
        var major: Major
        var recommendItems: [PostList]
        var postItems: [PostList]
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            major: UserDefaultsLocal.shared.major,
            recommendItems: [],
            postItems: []
        )
    }
    
}

// MARK: - Mutate
extension PostListReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .majorButtonDidTap:
            steps.accept(MoizaStep.majorSelectIsRequired)
        case .viewDidLoad:
            return viewDidLoad()
        case let .majorDidChange(major):
            return .just(.setMajor(major))
        case .sortButtonDidTap:
            steps.accept(MoizaStep.sortIsRequired([.sortType]))
        case .viewWillAppear:
            return viewWillAppear()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
        case let .postDidTap(id):
            steps.accept(MoizaStep.postDetailIsRequired(id))
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
        case let .setRecommendPostList(rec):
            newState.recommendItems = rec
        case let .setPostList(posts):
            newState.postItems = posts
        case let .updatePostList(posts):
            newState.postItems.append(contentsOf: posts)
        }
        
        return newState
    }
}

// MARK: - Method
private extension PostListReactor {
    func viewWillAppear() -> Observable<Mutation> {
        let recommend: [PostList] = [
            .dummy,
            .dummy,
            .dummy,
            .dummy,
            .dummy
        ].filter {
            if UserDefaultsLocal.shared.post == .all { return true }
            return $0.type == UserDefaultsLocal.shared.post
        }
        let posts: [PostList] = [
            .dummy,
            .dummy,
            .dummy,
            .dummy,
            .dummy
        ].filter {
            if UserDefaultsLocal.shared.post == .all { return true }
            return $0.type == UserDefaultsLocal.shared.post
        }
        return .concat([
            .just(.setRecommendPostList(recommend)),
            .just(.setPostList(posts))
        ])
    }
    func viewDidLoad() -> Observable<Mutation> {
        return .empty()
    }
    func pagenation(
        contentHeight: CGFloat,
        contentOffsetY: CGFloat,
        scrollViewHeight: CGFloat
    ) -> Observable<Mutation> {
        let padding = contentHeight - contentOffsetY
        if padding < scrollViewHeight {
            self.page += 1
            return Observable.just([
                .dummy,
                .dummy,
                .dummy,
                .dummy,
                .dummy
            ])
                .map(Mutation.updatePostList)
        } else {
            return .empty()
        }
    }
}

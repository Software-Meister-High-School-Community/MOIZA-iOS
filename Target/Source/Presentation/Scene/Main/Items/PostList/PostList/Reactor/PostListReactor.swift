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
            .init(id: 0, title: "앱아이콘 만드는 법", type: .normal, isLike: .random(), commentCount: 2, likeCount: 3, viewCount: 10, createdAt: Date()),
            .init(id: 1, title: "무슨질문", type: .question, isLike: .random(), commentCount: 2, likeCount: 3, viewCount: 20, createdAt: Date()),
            .init(id: 2, title: "앱아이콘 만드는 법", type: .normal, isLike: .random(), commentCount: 2, likeCount: 3, viewCount: 10, createdAt: Date()),
            .init(id: 3, title: "무슨질문", type: .question, isLike: .random(), commentCount: 2, likeCount: 3, viewCount: 20, createdAt: Date()),
            .init(id: 4, title: "앱아이콘 만드는 법", type: .normal, isLike: .random(), commentCount: 2, likeCount: 3, viewCount: 10, createdAt: Date()),
            .init(id: 5, title: "무슨질문", type: .question, isLike: .random(), commentCount: 2, likeCount: 3, viewCount: 20, createdAt: Date())
        ].filter {
            if UserDefaultsLocal.shared.post == .all { return true }
            return $0.type == UserDefaultsLocal.shared.post
        }
        let posts: [PostList] = [
            .init(id: 6, title: "대충 제목", type: .normal, isLike: .random(), commentCount: 2, likeCount: 19, viewCount: 26, createdAt: Date()),
            .init(id: 7, title: "제에목", type: .question, isLike: .random(), commentCount: 7, likeCount: 39, viewCount: 72, createdAt: Date()),
            .init(id: 8, title: "대충 제목", type: .normal, isLike: .random(), commentCount: 2, likeCount: 19, viewCount: 26, createdAt: Date()),
            .init(id: 9, title: "제에목", type: .question, isLike: .random(), commentCount: 7, likeCount: 39, viewCount: 72, createdAt: Date()),
            .init(id: 10, title: "대충 제목", type: .normal, isLike: .random(), commentCount: 2, likeCount: 19, viewCount: 26, createdAt: Date()),
            .init(id: 11, title: "제에목", type: .question, isLike: .random(), commentCount: 7, likeCount: 39, viewCount: 72, createdAt: Date())
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
            return Observable.just([PostList(id: currentState.postItems.count+1, title: "제에목", type: .question, isLike: .random(), commentCount: 27, likeCount: 38, viewCount: 294, createdAt: Date())])
                .map(Mutation.updatePostList)
        } else {
            return .empty()
        }
    }
}

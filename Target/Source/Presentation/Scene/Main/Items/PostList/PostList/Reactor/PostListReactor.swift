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

final class PostListReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case viewWillAppear
        case majorButtonDidTap
        case majorDidChange(Major)
    }
    enum Mutation {
        case setMajor(Major)
        case setRecommendPostList([PostList])
        case setPostList([PostList])
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
        case .viewWillAppear:
            return viewWillAppear()
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
        }
        
        return newState
    }
}

// MARK: - Method
private extension PostListReactor {
    func viewWillAppear() -> Observable<Mutation> {
        let recommend: [PostList] = [
            .init(title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3, liked: false),
            .init(title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3, liked: true),
            .init(title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3, liked: false),
            .init(title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3, liked: true),
            .init(title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3, liked: false),
            .init(title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3, liked: true)
        ].filter {
            if UserDefaultsLocal.shared.post == .all { return true }
            return $0.type == UserDefaultsLocal.shared.post
        }
        let posts: [PostList] = [
            .init(title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false),
            .init(title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .question, commentCount: 43, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false),
            .init(title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false),
            .init(title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .question, commentCount: 43, likeCount: 1, liked: true),
            .init(title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false)
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
}

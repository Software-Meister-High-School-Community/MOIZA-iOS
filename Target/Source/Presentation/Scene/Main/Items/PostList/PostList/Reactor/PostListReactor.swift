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
        case viewDidLoad
        case viewWillAppear
        case majorButtonDidTap
        case majorDidChange(Major)
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
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
        case .viewWillAppear:
            return viewWillAppear()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
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
            .init(id: "1", title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3, liked: false),
            .init(id: "2", title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3, liked: true),
            .init(id: "3", title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3, liked: false),
            .init(id: "4", title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3, liked: true),
            .init(id: "5", title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3, liked: false),
            .init(id: "6", title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3, liked: true)
        ].filter {
            if UserDefaultsLocal.shared.post == .all { return true }
            return $0.type == UserDefaultsLocal.shared.post
        }
        let posts: [PostList] = [
            .init(id: "1", title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(id: "2", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(id: "3", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(id: "4", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false),
            .init(id: "5", title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(id: "6", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(id: "7", title: "ㅁㄴㅇㅇ", type: .question, commentCount: 43, likeCount: 1, liked: true),
            .init(id: "8", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false),
            .init(id: "9", title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(id: "10", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(id: "11", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(id: "12", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false),
            .init(id: "13", title: "대충제목대충제목대충제목대충제목대충제목", type: .question, commentCount: 13, likeCount: 163, liked: false),
            .init(id: "14", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: true),
            .init(id: "15", title: "ㅁㄴㅇㅇ", type: .question, commentCount: 43, likeCount: 1, liked: true),
            .init(id: "16", title: "ㅁㄴㅇㅇ", type: .normal, commentCount: 2, likeCount: 1, liked: false)
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
            return Observable.just([PostList(id: UUID().uuidString, title: "ㅡㅗㅁㅇㄴㅊ", type: .allCases.randomElement() ?? .question, commentCount: 2, likeCount: 3, liked: .random())])
                .map(Mutation.updatePostList)
        } else {
            return .empty()
        }
    }
}

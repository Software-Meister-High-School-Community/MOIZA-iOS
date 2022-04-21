//
//  MyPageReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MyPageReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    
    // MARK: - Reactor
    enum Action {
        case ellipsisButtonDidTap
        case followerButtonDidTap
        case followingButtonDidTap
        case updatePost(Int)
        case updateFollower(Int)
        case updateFollwing(Int)
        case sortButtonDidTap
        case modifyButtonDidTap
        case settingButtonDidTap
        case viewWillAppear
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation {
        case setPost(Int)
        case setFollower(Int)
        case setFollowing(Int)
        case setPostList([PostList])
        case updatePostList([PostList])
    }
    struct State {
        var post: Int?
        var follower: Int?
        var following: Int?
        var postItems: [PostList]
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(postItems: [])
    }
    
}

// MARK: - Mutate
extension MyPageReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .ellipsisButtonDidTap:
            return .empty()
        case .followerButtonDidTap:
            steps.accept(MoizaStep.followerIsRequired)
            return .empty()
        case .followingButtonDidTap:
            steps.accept(MoizaStep.followingIsRequired)
            return .empty()
        case let .updatePost(post):
            return .just(.setPost(post))
        case let .updateFollower(follower):
            return .just(.setFollower(follower))
        case let .updateFollwing(following):
            return .just(.setFollowing(following))
        case .sortButtonDidTap:
            steps.accept(MoizaStep.sortIsRequired([.sortType,.major]))
            return .empty()
        case .modifyButtonDidTap:
            steps.accept(MoizaStep.myPageModifyIsRequired)
            return .empty()
        case .settingButtonDidTap:
            steps.accept(MoizaStep.myPageSettingIsRequired)
            return .empty()
        case .viewWillAppear:
            return viewWillAppear()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
        }
    }
}

// MARK: - Reduce
extension MyPageReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setPost(post):
            newState.post = post
        case let .setFollower(follower):
            newState.follower = follower
        case let .setFollowing(following):
            newState.following = following
        case let .setPostList(posts):
            newState.postItems = posts
        case let .updatePostList(posts):
            newState.postItems.append(contentsOf: posts)
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageReactor {
    func viewWillAppear() -> Observable<Mutation>{
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
            .just(.setPostList(posts))
        ])
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

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
        case sortDidCompleted(SortType, Major)
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
        case setSortOption(SortType, Major)
    }
    struct State {
        var post: Int?
        var follower: Int?
        var following: Int?
        var postItems: [PostList]
        var sortType: SortType
        var major: Major
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            postItems: [],
            sortType: .latest,
            major: UserDefaultsLocal.shared.major
        )
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
            steps.accept(MoizaStep.sortIsRequired([.sortType,.major], initial: (.all, currentState.sortType), onComplete: { [weak self] _, sort, major in
                self?.action.onNext(.sortDidCompleted(sort, major))
            }))
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
        case let .sortDidCompleted(sort, major):
            return .just(.setSortOption(sort, major))
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
        case let .setSortOption(sort, major):
            newState.sortType = sort
            newState.major = major
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageReactor {
    func viewWillAppear() -> Observable<Mutation>{
        return .concat([
            .just(.setPostList([.dummy, .dummy, .dummy]))
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

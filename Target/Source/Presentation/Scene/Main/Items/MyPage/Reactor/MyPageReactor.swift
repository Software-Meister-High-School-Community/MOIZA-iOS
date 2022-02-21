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
    
    // MARK: - Reactor
    enum Action {
        case dotButtonDidTap
        case followerButtonDidTap
        case followingButtonDidTap
        case updatePost(Int)
        case updateFollower(Int)
        case updateFollwing(Int)
        case sortButtonDidTap
    }
    enum Mutation {
        case setPost(Int)
        case setFollower(Int)
        case setFollowing(Int)
    }
    struct State {
        var post: Int?
        var follower: Int?
        var following: Int?
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension MyPageReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .dotButtonDidTap:
            return .empty()
        case .followerButtonDidTap:
            return .empty()
        case .followingButtonDidTap:
            return .empty()
        case let .updatePost(post):
            return .just(.setPost(post))
        case let .updateFollower(follower):
            return .just(.setFollower(follower))
        case let .updateFollwing(following):
            return .just(.setFollowing(following))
        case .sortButtonDidTap:
            return .empty()
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
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageReactor {
    
}

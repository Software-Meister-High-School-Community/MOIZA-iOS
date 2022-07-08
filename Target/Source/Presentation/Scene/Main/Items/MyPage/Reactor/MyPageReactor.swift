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
        case sortButtonDidTap
        case modifyButtonDidTap
        case settingButtonDidTap
        case viewWillAppear
        case sortDidCompleted(SortType, Major)
        case reachedBottom
    }
    enum Mutation {
        case setUserProfile(UserProfile)
        case setPostList([PostList])
        case updatePostList([PostList])
        case setSortOption(SortType, Major)
    }
    struct State {
        var profile: UserProfile?
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
        case let .sortDidCompleted(sort, major):
            return .just(.setSortOption(sort, major))
        case .reachedBottom:
            return reachedBottom()
        }
    }
}

// MARK: - Reduce
extension MyPageReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setPostList(posts):
            newState.postItems = posts
        case let .setUserProfile(user):
            newState.profile = user
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
            .just(.setUserProfile(.dummy)),
            .just(.setPostList([.dummy, .dummy]))
        ])
    }
    func reachedBottom() -> Observable<Mutation> {
        self.page += 1
        return .just(.updatePostList([.dummy, .dummy, .dummy]))
    }
}

//
//  ModifyProfileReactor.swift
//  MOIZA
//
//  Created by 임준화 on 2022/06/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class ModifyProfileReactor: Reactor, Stepper {
    
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    
    // MARK: - Reactor
    enum Action {
        case ellipsisButtonDidTap
        case followerButtonDidTap
        case followingButtonDidTap
        case updateFollower(Int)
        case updateFollwing(Int)
        case changeProfileButtonDidTap
        case modifyButtonDidTap
        case settingButtonDidTap
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation {
        case setFollower(Int)
        case setFollowing(Int)
    }
    struct State {
        var follower: Int?
        var following: Int?
    }
    
    let initialState: State
    // MARK: - Init
    init(){
        initialState = State()
    }
}

// MARK: - Mutate
extension ModifyProfileReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .ellipsisButtonDidTap:
            return .empty()
        case .followerButtonDidTap:
            steps.accept(MoizaStep.followerIsRequired)
            return .empty()
        case .followingButtonDidTap:
            steps.accept(MoizaStep.followerIsRequired)
            return .empty()
        case let .updateFollower(follower):
            return .just(.setFollower(follower))
        case let .updateFollwing(following):
            return .just(.setFollowing(following))
        case .changeProfileButtonDidTap:
            steps.accept(MoizaStep.changeProfileIsRequired)
            return .empty()
        case .modifyButtonDidTap:
            steps.accept(MoizaStep.myPageModifyIsRequired)
            return .empty()
        case .settingButtonDidTap:
            steps.accept(MoizaStep.myPageSettingIsRequired)
            return .empty()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
        }
    }
}

// MARK: - Reduce
extension ModifyProfileReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setFollower(follower):
            newState.follower = follower
        case let .setFollowing(following):
            newState.following = following
        }
        return newState
    }
}

// MARK: - Method
private extension ModifyProfileReactor {
    func pagenation(
        contentHeight: CGFloat,
        contentOffsetY: CGFloat,
        scrollViewHeight: CGFloat
    ) -> Observable<Mutation> {
        let padding = contentHeight - contentOffsetY
        if padding < scrollViewHeight {
            self.page += 1
        }
        return .empty()
    }
}

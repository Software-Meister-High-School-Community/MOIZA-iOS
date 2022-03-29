//
//  MyPageFollowReactor.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/23.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class MyPageFollowReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private var page: Int = 0
    // MARK: - Reactor
    enum Action {
        case viewWillAppear
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation {
        case setFollowerList([UserList])
        case updateFollowerList([UserList])
    }
    struct State {
        var FollowerItems: [UserList]
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(FollowerItems: [])
    }
    
}

// MARK: - Mutate
extension MyPageFollowReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return viewWillAppear()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
        }
    }
}

// MARK: - Reduce
extension MyPageFollowReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setFollowerList(followers):
            newState.FollowerItems = followers
        case let .updateFollowerList(followers):
            newState.FollowerItems.append(contentsOf: followers)
        }
        return newState
    }
}

// MARK: - Method
private extension MyPageFollowReactor {
    func viewWillAppear() -> Observable<Mutation>{
        let follower: [UserList] = [
            .init(userID: 6, name: "최형우", profileImageURL: "ㅁㄴㅇ", school: .gsm, userScope: .user, isFollow: .random()),
            .init(userID: 7, name: "김상은", profileImageURL: "ㅁㄴㅇㄹ", school: .dgsm, userScope: .user, isFollow: .random())
        ]
        return .concat([
            .just(.setFollowerList(follower))
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
            return Observable.just([UserList(userID: currentState.FollowerItems.count+1, name: "최형우", profileImageURL: "ads", school: .gsm, userScope: .user, isFollow: .random())])
                .map(Mutation.updateFollowerList)
        } else {
            return .empty()
        }
    }
}

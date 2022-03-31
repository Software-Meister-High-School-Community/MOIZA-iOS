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
            .init(userID: 0, name: "최형우", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .gsm, userScope: .student, isFollow: .random()),
            .init(userID: 1, name: "김상은", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .dgsm, userScope: .student, isFollow: .random())
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
            return Observable.just([UserList(userID: currentState.FollowerItems.count+1, name: "최형우", profileImageURL: "https://avatars.githubusercontent.com/u/76590302?s=400&u=2b40b74acd6eca17e346471f3e7028bdd2c1e14a&v=4", school: .gsm, userScope: .user, isFollow: .random())])
                .map(Mutation.updateFollowerList)
        } else {
            return .empty()
        }
    }
}

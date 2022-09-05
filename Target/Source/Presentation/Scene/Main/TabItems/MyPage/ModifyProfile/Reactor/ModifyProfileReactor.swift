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
        case followerButtonDidTap
        case followingButtonDidTap
        case updateFollower(Int)
        case updateFollwing(Int)
        case introduceButtonDidTap
        case websiteButtonDidTap
        case imageDidSelected(Data?, String)
        case alert(title: String?, message: String, style: UIAlertController.Style, actions: [UIAlertAction])
        case errorAlert(title: String?, message: String)
        case cancelButtonDidTap
        case pagenation(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
        case saveButtonDidTap
    }
    enum Mutation {
        case setFollower(Int)
        case setFollowing(Int)
        case setImage(Data?)
    }
    struct State {
        var follower: Int?
        var following: Int?
        var selectedData: Data?
    }
    
    let initialState: State
    // MARK: - Init
    init(){
        initialState = State(
            follower: 0,
            following: 0,
            selectedData: nil
        )
    }
}

// MARK: - Mutate
extension ModifyProfileReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
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
        case .imageDidSelected:
            steps.accept(MoizaStep.changeProfileIsRequired)
            return .empty()
        case .introduceButtonDidTap:
            steps.accept(MoizaStep.myPageIntroduceModifyIsRequired)
            return .empty()
        case .websiteButtonDidTap:
            steps.accept(MoizaStep.myPageWebsiteAddIsRequired)
            return .empty()
        case let .pagenation(contentHeight, contentOffsetY, scrollViewHeight):
            return pagenation(contentHeight: contentHeight, contentOffsetY: contentOffsetY, scrollViewHeight: scrollViewHeight)
        case let .alert(title, message, style, actions):
            steps.accept(MoizaStep.alert(title: title, message: message, style: style, actions: actions))
        case let .errorAlert(title, message):
            steps.accept(MoizaStep.errorAlert(title: title, message: message))
        case .cancelButtonDidTap:
            return .concat([
                .just(.setImage(nil))
            ])
        case .saveButtonDidTap:
            steps.accept(MoizaStep.myPageIsRequired)
            return .empty()
        }
        return .empty()
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
        case let .setImage(data):
            newState.selectedData = data
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

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
        case majorButtonDidTap
        case majorDidChange(Major)
        case sortButtonDidTap
    }
    enum Mutation {
        case setMajor(Major)
        case setRecommendPostList([PostList])
    }
    struct State {
        var major: Major
        var recommendItem: [PostList]
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            major: UserDefaultsLocal.shared.major,
            recommendItem: []
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
        case .sortButtonDidTap:
            steps.accept(MoizaStep.sortIsRequired([.sortType]))
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
            newState.recommendItem = rec
        }
        
        return newState
    }
}

// MARK: - Method
private extension PostListReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let recommend: [PostList] = [
            .init(title: "앱 아이콘 만드는 법", type: .question, commentCount: 2, likeCount: 3),
            .init(title: "일러스트에서 아주 그냥 asdfasdfasdf", type: .normal, commentCount: 3, likeCount: 3)
        ]
        return .concat([
            .just(.setRecommendPostList(recommend))
        ])
    }
}

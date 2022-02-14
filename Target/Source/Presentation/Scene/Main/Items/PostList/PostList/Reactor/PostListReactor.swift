//
//  PostListReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
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
        
    }
    enum Mutation {
        
    }
    struct State {
        var selectedMajor: Major
    }
    let initialState: State
    
    // MARK: - Init
    init(category major: Major) {
        initialState = State(
            selectedMajor: major
        )
    }
    
}

// MARK: - Mutate
extension PostListReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension PostListReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension PostListReactor {
    
}

//
//  MyPageFollowVC.swift
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
    
    // MARK: - Reactor
    enum Action {
        
    }
    enum Mutation {
        
    }
    struct State {
       
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension MyPageFollowReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
}

// MARK: - Reduce
extension MyPageFollowReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        return newState
    }
}

// MARK: - Method
private extension MyPageFollowReactor {
    
}


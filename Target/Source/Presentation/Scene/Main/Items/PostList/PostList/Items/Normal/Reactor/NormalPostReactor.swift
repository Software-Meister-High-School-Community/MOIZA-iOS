//
//  NormalPostReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/20.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class NormalPostReactor: Reactor, Stepper {
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
extension NormalPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension NormalPostReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension NormalPostReactor {
    
}

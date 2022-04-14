//
//  FindIDReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/07.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class FindIDReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
        case updateEmail(String)
    }
    enum Mutation {
        case setEmail(String)
        case setIsValid(Bool)
        
    }
    struct State {
        var isValid: Bool
        var email: String
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            isValid: false,
            email: ""
        )
    }
    
}

// MARK: - Mutate
extension FindIDReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return nextButtonDidTap()
        case let .updateEmail(num):
            return .just(.setEmail(num))
        }
    }
}

extension FindIDReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setEmail(email):
            newState.email = email
        case let .setIsValid(valid):
            newState.isValid = valid
        }
        newState.isValid = checkValidation(newState)
        
        return newState
    }
}

// MARK: - Method
private extension FindIDReactor {
    func nextButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.certIsRequired)
        return .empty()
    }
    func checkValidation(_ state: State) -> Bool {
        guard !state.email.isEmpty else { return false }
        return true
    }
}

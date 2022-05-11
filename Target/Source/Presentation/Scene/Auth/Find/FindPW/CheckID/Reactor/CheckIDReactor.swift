//
//  CheckIDReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import PinLayout

final class CheckIDReactor: Stepper, Reactor {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
        case updateId(String)
    }
    enum Mutation {
        case setId(String)
        case setIsValid(Bool)
    }
    struct State {
        var id: String
        var isValid: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            id: "",
            isValid: false
        )
    }
}

// MARK: - Mutate
extension CheckIDReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return nextButtonDidTap()
        case let .updateId(id):
            return .just(.setId(id))
        }
    }
}

// MARK: - Reduce
extension CheckIDReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setId(id):
            newState.id = id
        case let .setIsValid(valid):
            newState.isValid = valid
        }
        newState.isValid = checkValidation(newState)
        
        return newState
    }
}

// MARK: - Method
private extension CheckIDReactor {
    func nextButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.sendCertRequired("ksemms20@dgsw.hs.kr"/* Todo: 받아온 email 넣어주기 */))
        return .empty()
    }
    func checkValidation(_ state: State) -> Bool {
        guard !state.id.isEmpty else { return false }
        return true
    }
}

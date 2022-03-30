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
        case updateCertNumber(String)
        case reCertButtonDidTap
    }
    enum Mutation {
        case setCertNumber(String)
        case setIsValid(Bool)
        
    }
    struct State {
        var certNumber: String
        var isValid: Bool
        var certIsCorrect: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            certNumber: "",
            isValid: false,
            certIsCorrect: true
        )
    }
    
}

// MARK: - Mutate
extension FindIDReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return nextButtonDidTap()
        case let .updateCertNumber(num):
            return .just(.setCertNumber(num))
        case .reCertButtonDidTap:
            return .empty()
        }
        return .empty()
    }
}

extension FindIDReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setCertNumber(num):
            newState.certNumber = num
        case let .setIsValid(valid):
            newState.isValid = valid
        }
        
        return newState
    }
}

// MARK: - Method
private extension FindIDReactor {
    func nextButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.certIsRequired)
        return .empty()
    }
}

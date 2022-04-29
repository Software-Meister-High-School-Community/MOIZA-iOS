//
//  SendCertReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SendCertReactor: Stepper, Reactor {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
        case updateCertNumber(String)
    }
    enum Mutation {
        case certIsCorrect(Bool)
        case setCertNumber(String)
    }
    struct State {
        var certNumber: String
        var isValid: Bool
        var certIsCorrect: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        self.initialState = State(
            certNumber: "",
            isValid: false,
            certIsCorrect: true
        )
    }
}

// MARK: - Mutate
extension SendCertReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return navToReRegistor()
        case let .updateCertNumber(certNumber):
            return .just(.setCertNumber(certNumber))
        }
    }
}

// MARK: - Reduce
extension SendCertReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setCertNumber(certNumber):
            newState.certNumber = certNumber
        case let .certIsCorrect(correct):
            newState.certIsCorrect = checkCertIsCorrect(newState)
        }
        newState.isValid = checkValidtion(newState)
        return newState
    }
}
// MARK: - Method
private extension SendCertReactor {
    func navToReRegistor() -> Observable<Mutation> {
        steps.accept(MoizaStep.reRegistorRequired)
        return .empty()
    }
    func checkValidtion(_ state: State) -> Bool {
        guard !state.certNumber.isEmpty else { return false }
        return true
    }
    func checkCertIsCorrect(_ state: State) -> Bool {
        return true
    }
}

//
//  CertEmailReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/11.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class CertEmailReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case reCertButtonDidTap
        case nextButtonDidTap
        case updateEmail(String)
    }
    enum Mutation {
        case setEmail(String)
    }
    struct State {
        var isValid: Bool
        var email: String
        var emailValid: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            isValid: false,
            email: "",
            emailValid: true
        )
    }
}

// MARK: - Mutate
extension CertEmailReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .reCertButtonDidTap:
            return .empty()
        case .nextButtonDidTap:
            return nextButtonDidTap()
        case let .updateEmail(email):
            return .just(.setEmail(email))
        }
    }
}

// MARK: - Reduce
extension CertEmailReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setEmail(email):
            newState.email = email
            newState.emailValid = checkCertNumisVaild(email)
        }
        newState.isValid = checkValidation(newState)
        return newState
    }
}

// MARK: - Method
private extension CertEmailReactor {
    func nextButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.successFindIDRequired)
        return .empty()
    }
    func checkValidation(_ state: State) -> Bool {
        guard !state.email.isEmpty else { return false }
        return true
    }
    func checkCertNumisVaild(_ certNum: String) -> Bool {
        // Todo: 서버에서 값받아와서 비교
        return true
    }
    func reCertButtonDidTap() {
        // Todo: 서버에 CertNum 다시 보내라고 요청
    }
}

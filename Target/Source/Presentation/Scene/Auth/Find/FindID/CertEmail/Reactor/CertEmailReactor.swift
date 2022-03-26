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
    }
    enum Mutation {
        case setIsValid(Bool)
        case setEmail(String)
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
extension CertEmailReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .reCertButtonDidTap:
            return .empty()
        case .nextButtonDidTap:
            return nextButtonDidTap()
        }
    }
}


// MARK: - Method
private extension CertEmailReactor {
    func nextButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.successFindIDRequired)
        return .empty()
    }
}

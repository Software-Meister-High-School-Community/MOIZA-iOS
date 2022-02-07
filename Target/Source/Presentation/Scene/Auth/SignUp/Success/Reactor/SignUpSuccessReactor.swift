//
//  SignUpSuccessReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/05.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class SignUpSuccessReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case signUpButtonDidTap
    }
    enum Mutation {}
    struct State {
        
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension SignUpSuccessReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signUpButtonDidTap:
            steps.accept(MoizaStep.signUpIsCompleted)
            return .empty()
        }
    }
}

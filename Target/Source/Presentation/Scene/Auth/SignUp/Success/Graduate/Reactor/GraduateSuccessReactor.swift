//
//  GraduateSuccessReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/09.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class GraduateSuccessReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case signInButtonDidTap
    }
    enum Mutation {}
    struct State {}
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension GraduateSuccessReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInButtonDidTap:
            steps.accept(MoizaStep.signUpGraduateAuthIsCompleted)
            return .empty()
        }
    }
}

//
//  GraduateAuthReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class GraduateAuthReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
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
extension GraduateAuthReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            steps.accept(MoizaStep.signUpGraduateAuthFileIsRequired)
            return .empty()
        case .signInButtonDidTap:
            steps.accept(MoizaStep.signUpIsCompleted)
            return .empty()
        }
    }
}

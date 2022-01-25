//
//  OnBoardingReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class OnBoardingReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case signUpButtonDidTap
        case signInButtonDidTap
    }
    enum Mutation{
    }
    struct State{
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension OnBoardingReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .signUpButtonDidTap:
            steps.accept(MoizaStep.signUpIsRequired)
            return .empty()
        case .signInButtonDidTap:
            steps.accept(MoizaStep.signInIsRequired)
            return .empty()
        }
    }
}

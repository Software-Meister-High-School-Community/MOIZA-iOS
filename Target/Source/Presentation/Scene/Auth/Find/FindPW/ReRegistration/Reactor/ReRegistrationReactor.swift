//
//  ReRegistrationReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class ReRegistrationReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
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
extension ReRegistrationReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return navToSucFindPW()
        }
    }
}

// MARK: - Method
private extension ReRegistrationReactor {
    func navToSucFindPW() -> Observable<Mutation> {
        steps.accept(MoizaStep.successFindPWRequired)
        return .empty()
    }
}

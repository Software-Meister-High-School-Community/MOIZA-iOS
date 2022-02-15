//
//  SucFindIDReacter.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/14.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SucFindIDReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case navToSingInButtonDidTap
        case findPWButtonDidTap
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
extension SucFindIDReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .findPWButtonDidTap:
            return findPWButtonDidTap()
        case .navToSingInButtonDidTap:
            return navToSingInButtonDidTap()
        }
    }
}


// MARK: - Method
private extension SucFindIDReactor {
    func findPWButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.findingPasswordIsRequired)
        return .empty()
    }
    func navToSingInButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.signInIsRequired)
        return .empty()
    }
}

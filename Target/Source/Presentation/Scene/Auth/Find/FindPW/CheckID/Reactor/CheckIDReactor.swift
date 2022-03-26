//
//  CheckIDReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class CheckIDReactor: Stepper, Reactor {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
    }
    enum Mutation {
        case setUserId(String)
        case setIsValid
    }
    struct State {
        var userId: String
        var isValid: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            userId: "",
            isValid: false
        )
    }
}

// MARK: - Mutate
extension CheckIDReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return nextButtonDidTap()
        }
    }
}

// MARK: - Method
private extension CheckIDReactor {
    func nextButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.sendCertRequired)
        return .empty()
    }
}

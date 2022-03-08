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
        case viewWillAppear
    }
    enum Mutation {
        case setEmail
    }
    struct State {
        var email: String
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        self.initialState = State(email: "???")
    }
}

// MARK: - Mutate
extension SendCertReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return navToReRegistor()
        case .viewWillAppear:
            return Observable.just(.setEmail)
        }
    }
}

// MARK: - Reduce
extension SendCertReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEmail:
            state.email = "받아온 이메일"
            return state
        }
    }
}
// MARK: - Method
private extension SendCertReactor {
    func navToReRegistor() -> Observable<Mutation> {
        steps.accept(MoizaStep.reRegistorRequired)
        return .empty()
    }
    func getEmail() -> Observable<Mutation> {
        return .empty()
    }
}

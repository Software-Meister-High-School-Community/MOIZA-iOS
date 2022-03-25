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
        case navToSignInButtonDidTap
        case findPWButtonDidTap
    }
    enum Mutation {}
    struct State {
        var userName: String
        var userID: String
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            userName: "",
            userID: ""
        )
    }
}

// MARK: - Mutate
extension SucFindIDReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .findPWButtonDidTap:
            return findPWButtonDidTap()
        case .navToSignInButtonDidTap:
            return navToSignInVC()
        }
    }
}


// MARK: - Method
private extension SucFindIDReactor {
    func findPWButtonDidTap() -> Observable<Mutation> {
        steps.accept(MoizaStep.findingPasswordIsRequired)
        return .empty()
    }
    func navToSignInVC() -> Observable<Mutation> {
        steps.accept(MoizaStep.signInIsRequired)
        return .empty()
    }
}

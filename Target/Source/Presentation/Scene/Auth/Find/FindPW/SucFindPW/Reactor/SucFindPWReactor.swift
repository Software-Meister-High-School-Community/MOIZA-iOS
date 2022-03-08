//
//  SucFindPWReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import PinLayout
import UIKit

final class SucFindPWReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()

    // MARK: - Reactor
    enum Action {
        case navToSignInButtonDidTap
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
extension SucFindPWReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .navToSignInButtonDidTap:
            return navToSignInVC()
        }
    }
}

// MARK: - Method
private extension SucFindPWReactor {
    func navToSignInVC() -> Observable<Mutation> {
        steps.accept(MoizaStep.signInIsRequired)
        return .empty()
    }
}

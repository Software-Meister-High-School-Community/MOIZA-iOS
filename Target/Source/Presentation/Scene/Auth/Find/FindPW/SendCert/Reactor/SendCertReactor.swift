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
extension SendCertReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return navToReRegistor()
        }
    }
}

// MARK: - Method
private extension SendCertReactor {
    func navToReRegistor() -> Observable<Mutation> {
        steps.accept(MoizaStep.reRegistorRequired)
        return .empty()
    }
}

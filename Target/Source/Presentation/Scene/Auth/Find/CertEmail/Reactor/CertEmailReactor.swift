//
//  CertEmailReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/11.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class CertEmailReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case reCertButtonDidTap
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
extension CertEmailReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .reCertButtonDidTap:
            return .empty()
        case .nextButtonDidTap:
            return .empty()
        }
    }
}

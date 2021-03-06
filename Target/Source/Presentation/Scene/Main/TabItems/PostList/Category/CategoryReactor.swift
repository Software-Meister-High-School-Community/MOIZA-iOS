//
//  CategoryReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class CategoryReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case categoryButtonDidTap(Major)
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
extension CategoryReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .categoryButtonDidTap(major):
            UserDefaultsLocal.shared.major = major
            steps.accept(MoizaStep.postListIsRequired)
        }
        return .empty()
    }
}

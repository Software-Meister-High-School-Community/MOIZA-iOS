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
    enum Action {}
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
        
    }
}

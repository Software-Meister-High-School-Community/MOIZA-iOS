//
//  SignUpSetUpReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SignUpSetUpReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case `init`(Student)
    }
    enum Mutation{
        case setStudent(Student)
    }
    struct State{
        var student: Student = .init(kind: .student, name: "", gender: .male, birth: .init(), school: .none, email: "")
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension SignUpSetUpReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .`init`(student):
            return .just(.setStudent(student))
        }
    }
}

// MARK: - Reduce
extension SignUpSetUpReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setStudent(student):
            newState.student = student
        }
        return newState
    }
}


// MARK: - Method
private extension SignUpSetUpReactor{
    
}

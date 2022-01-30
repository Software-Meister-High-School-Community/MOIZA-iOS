//
//  SignUpInfoReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SignUpInfoReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case studentKindButtonDidTap(StudentKind)
        case updateName(String)
        case genderButtonDidTap(Gender)
        case updateBirth(Date)
        case schoolButtonDidTap(School)
        case updateEmail(String)
        case updateEmailType(String)
        case authRequestButtonDidTap
        case updateAuthCode(String)
    }
    enum Mutation{
        case setStudentKind(StudentKind)
        case setName(String)
        case setGender(Gender)
        case setBirth(Date)
        case setSchool(School)
        case setEmail(String)
        case setEmailType(String)
        case setAuthCode(String)
    }
    struct State{
        var studentKind: StudentKind = .student
        var name: String = ""
        var gender: Gender?
        var birth: Date = .init()
        var school: School?
        var email: String = ""
        var emailType: String = ""
        var authCode: String = ""
        var authCodeValidation: Bool = true
        var signUpValid: Bool = false
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension SignUpInfoReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .studentKindButtonDidTap(kind):
            return .just(.setStudentKind(kind))
        case let .updateName(name):
            return .just(.setName(name))
        case let .genderButtonDidTap(gender):
            return .just(.setGender(gender))
        case let .updateBirth(birth):
            return .just(.setBirth(birth))
        case let .schoolButtonDidTap(sch):
            return .just(.setSchool(sch))
        case let .updateEmail(email):
            return .just(.setEmail(email))
        case let .updateEmailType(emailType):
            return .just(.setEmailType(emailType))
        case .authRequestButtonDidTap:
            return .empty()
        case let .updateAuthCode(code):
            return .just(.setAuthCode(code))
        }
    }
}

// MARK: - Reduce
extension SignUpInfoReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setStudentKind(kind):
            newState.studentKind = kind
        case let .setName(name):
            newState.name = name
        case let .setGender(gender):
            newState.gender = gender
        case let .setBirth(birth):
            newState.birth = birth
        case let .setSchool(sch):
            newState.school = sch
            newState.emailType = sch.toDomain()
        case let .setEmail(email):
            newState.email = email
        case let .setEmailType(emailType):
            newState.emailType = emailType
        case let .setAuthCode(code):
            newState.authCode = code
        }
        newState.signUpValid = checkValidation(newState)
        return newState
    }
}


// MARK: - Method
private extension SignUpInfoReactor{
    func checkValidation(_ currentState: State) -> Bool {
        guard !currentState.name.isEmpty,
              currentState.gender != nil,
              currentState.school != nil,
              !currentState.email.isEmpty,
              !currentState.emailType.isEmpty,
              currentState.authCodeValidation else {
            return false
        }
        
        return true
    }
}

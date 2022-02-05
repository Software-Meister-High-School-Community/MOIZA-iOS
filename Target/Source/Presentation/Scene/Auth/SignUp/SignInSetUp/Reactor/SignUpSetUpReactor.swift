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
        case updateId(String)
        case updatePassword(String)
        case updatePasswordCheck(String)
        case isIdExistButtonDidTap
        case pwdVisibleButtonDidTap
        case pwdCheckVisibleButtonDidTap
        case nextButtonDidTap
    }
    enum Mutation{
        case setId(String)
        case setPassword(String)
        case setPasswordCheck(String)
        case setPwdVisible(Bool)
        case setPwdCheckVisible(Bool)
        case setIdExist(Bool)
    }
    struct State{
        var student: Student
        var id: String
        var idExist: Bool
        var password: String
        var pwdVisible: Bool
        var passwordCheck: String
        var pwdCheckVisible: Bool
        var passwordValid: Bool
        var passwordCheckedValid: Bool
        var valid: Bool
    }
    
    var initialState: State
    
    // MARK: - Init
    init(student: Student){
        self.initialState = State(
            student: student,
            id: "",
            idExist: true, // TODO: validCheck
            password: "",
            pwdVisible: true,
            passwordCheck: "",
            pwdCheckVisible: true,
            passwordValid: false,
            passwordCheckedValid: false,
            valid: false
        )
    }
}

// MARK: - Mutate
extension SignUpSetUpReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .updateId(id):
            return .just(.setId(id))
        case let .updatePassword(pwd):
            return .just(.setPassword(pwd))
        case let .updatePasswordCheck(pwd):
            return .just(.setPasswordCheck(pwd))
        case .isIdExistButtonDidTap:
            return checkIdExist()
        case .nextButtonDidTap:
            // TODO: api
            return nextButtonDidTap()
        case .pwdVisibleButtonDidTap:
            return .just(.setPwdVisible(!currentState.pwdVisible))
        case .pwdCheckVisibleButtonDidTap:
            return .just(.setPwdCheckVisible(!currentState.pwdCheckVisible))
        }
    }
}

// MARK: - Reduce
extension SignUpSetUpReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setId(id):
            newState.id = id
            newState.idExist = true
        case let .setIdExist(exist):
            newState.idExist = exist
        case let .setPassword(pwd):
            newState.password = pwd
            newState.passwordCheckedValid = checkPasswordCheckValidation(pwd: pwd, pwdChk: currentState.passwordCheck)
            newState.passwordValid = checkPasswordValidation(pwd)
        case let .setPwdVisible(visible):
            newState.pwdVisible = visible
        case let .setPasswordCheck(pwd):
            newState.passwordCheck = pwd
            newState.passwordCheckedValid = checkPasswordCheckValidation(pwd: currentState.password, pwdChk: pwd)
        case let .setPwdCheckVisible(visible):
            newState.pwdCheckVisible = visible
        }
        newState.valid = checkValidation(newState)
        return newState
    }
}


// MARK: - Method
private extension SignUpSetUpReactor{
    func checkIdExist() -> Observable<Mutation>{
        // TODO: api
        return .just(.setIdExist(false))
    }
    func nextButtonDidTap() -> Observable<Mutation> {
        if currentState.student.kind == .student {
            steps.accept(MoizaStep.signUpSuccessIsRequired)
        } else if currentState.student.kind == .graduate {
            // TODO: 졸업생인증
        } 
        return .empty()
    }
    func checkValidation(_ state: State) -> Bool{
        guard !state.id.isEmpty,
              !state.idExist,
              state.passwordValid,
              state.passwordCheckedValid,
              checkPasswordCheckValidation(pwd: state.password, pwdChk: state.passwordCheck)
        else {
            return false
        }
        return true
    }
    func checkPasswordValidation(_ pwd: String) -> Bool{
        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,16}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        if let _ = regex?.firstMatch(in: pwd, options: [], range: .init(location: 0, length: pwd.count)) {
            return true
        }
        return false
    }
    func checkPasswordCheckValidation(pwd: String, pwdChk: String) -> Bool{
        return pwd == pwdChk
    }
}

//
//  SignInReactor.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/07.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxRelay

final class SignInReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case updateId(String)
        case updatePassword(String)
        case pwdVisibleButtonDidTap
        case autoLoginButtonDidTap
        case saveIdButtonDidTap
        case logInButtonDidTap
        case signUpButtonDidTap
        case findIdButtonDidTap
        case findPwdButtonDidTap
    }
    enum Mutation{
        case setId(String)
        case setPassword(String)
        case setIsOnAutoLogin(Bool)
        case setIsOnIdSave(Bool)
        case setPasswordVisible(Bool)
        case setIsSignInInvalid
    }
    struct State{
        var id: String
        var password: String
        var isOnAutoLogin: Bool
        var isOnIdSave: Bool
        var isSignInValid: Bool
        var passwordVisible: Bool
        var isSignInInvalid: Bool
    }
    var initialState: State
    
    init(){
        initialState = State(
            id: "",
            password: "",
            isOnAutoLogin: false,
            isOnIdSave: false,
            isSignInValid: false,
            passwordVisible: false,
            isSignInInvalid: false)
    }
}

// MARK: - Mutate
extension SignInReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .updateId(id):
            return .just(.setId(id))
        case let .updatePassword(pwd):
            return .just(.setPassword(pwd))
        case .pwdVisibleButtonDidTap:
            return Observable.just(.setPasswordVisible(!currentState.passwordVisible))
        case .autoLoginButtonDidTap:
            return Observable.just(.setIsOnAutoLogin(!currentState.isOnAutoLogin))
        case .saveIdButtonDidTap:
            return Observable.just(.setIsOnIdSave(!currentState.isOnIdSave))
        case .logInButtonDidTap:
            return .empty()
        case .signUpButtonDidTap:
            return .empty()
        case .findIdButtonDidTap:
            return .empty()
        case .findPwdButtonDidTap:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension SignInReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation{
        case let .setId(id):
            newState.id = id
        case let .setPassword(password):
            newState.password = password
        case let .setIsOnAutoLogin(isOnAutoLogin):
            newState.isOnAutoLogin = isOnAutoLogin
        case let .setIsOnIdSave(isOnIdSave):
            newState.isOnIdSave  = isOnIdSave
        case let .setPasswordVisible(passwordVisible):
            newState.passwordVisible = passwordVisible
        case .setIsSignInInvalid:
            newState.isSignInInvalid = false
        }
        newState.isSignInValid = checkValidation(newState)
        return newState
    }
}
private extension SignInReactor{
    func checkValidation(_ state:State) -> Bool{
        guard !state.id.isEmpty,
              !state.password.isEmpty
        else {
            return false
        }
        return true
    }
}

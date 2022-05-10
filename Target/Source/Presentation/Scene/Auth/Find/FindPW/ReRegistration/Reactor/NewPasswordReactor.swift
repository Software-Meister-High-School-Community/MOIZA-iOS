//
//  ReRegistrationReactor.swift
//  MOIZA
//
//  Created by 김상금 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class NewPasswordReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case nextButtonDidTap
        case updateNewPassword(String)
        case updateNewPasswordCheck(String)
        case newPwdVisibleButtinDidTap
        case newPwdCheckVisibleButtonDidTap
    }
    enum Mutation {
        case setNewPassword(String)
        case setNewPasswordVisible(Bool)
        case setNewPasswordCheck(String)
        case setNewPasswordCheckVisible(Bool)
    }
    struct State {
        var passwordIsCorrect: Bool
        var valid: Bool
        var newPassword: String
        var newPasswordVisible: Bool
        var newPasswordCheck: String
        var newPasswordCheckVisible: Bool
        var newPasswordValid: Bool
        var newPasswordCheckedValid: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            passwordIsCorrect: true,
            valid: false,
            newPassword: "",
            newPasswordVisible: true,
            newPasswordCheck: "",
            newPasswordCheckVisible: true,
            newPasswordValid: false,
            newPasswordCheckedValid: false
        )
    }
}

// MARK: - Mutate
extension NewPasswordReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return navToSucFindPW()
        case let .updateNewPassword(newPwd):
            return .just(.setNewPassword(newPwd))
        case let .updateNewPasswordCheck(newPwd):
            return .just(.setNewPasswordCheck(newPwd))
        case .newPwdVisibleButtinDidTap:
            return .just(.setNewPasswordVisible(!currentState.newPasswordVisible))
        case .newPwdCheckVisibleButtonDidTap:
            return .just(.setNewPasswordCheckVisible(!currentState.newPasswordCheckVisible))
        }
    }
}

// MARK: - Reduce
extension NewPasswordReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setNewPassword(newPwd):
            newState.newPassword = newPwd
            newState.newPasswordValid = checkPasswordCheckValidation(pwd: newPwd, pwdChk: currentState.newPasswordCheck)
        case let .setNewPasswordCheck(newPwdCheck):
            newState.newPasswordCheck = newPwdCheck
            newState.newPasswordValid = checkPasswordCheckValidation(pwd: currentState.newPassword, pwdChk: newPwdCheck)
        case let .setNewPasswordVisible(visible):
            newState.newPasswordVisible = visible
        case let.setNewPasswordCheckVisible(visible):
            newState.newPasswordCheckVisible = visible
        }
        newState.valid = checkValidation(newState)
        
        return newState
    }
}

// MARK: - Method
private extension NewPasswordReactor {
    func navToSucFindPW() -> Observable<Mutation> {
        steps.accept(MoizaStep.successFindPWRequired)
        return .empty()
    }
    func checkValidation(_ state: State) -> Bool {
        guard !state.newPassword.isEmpty,
              !state.newPasswordCheck.isEmpty,
              checkPasswordCheckValidation(pwd: state.newPassword, pwdChk: state.newPasswordCheck)
        else { return false }
        return true
    }
    func checkPassWordValdation(_ pwd: String) -> Bool {
        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,16}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        if let _ = regex?.firstMatch(in: pwd, options: [], range: .init(location: 0, length: pwd.count)) { return true }
        return false
    }
    func checkPasswordCheckValidation(pwd: String, pwdChk: String) -> Bool {
        return pwd == pwdChk
    }
}

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
        case updateNewPassWordCheck(String)
        case newPwdVisibleButtinDidTap
        case newPwdCheckVisibleButtonDidTap
    }
    enum Mutation {
        case setNewPassWord(String)
        case setNewPassWordVisible(Bool)
        case setNewPassWordCheck(String)
        case setNewPassWordCheckVisible(Bool)
    }
    struct State {
        var passWordIsCorrect: Bool
        var valid: Bool
        var newPassWord: String
        var newPassWordVisible: Bool
        var newPassWordCheck: String
        var newPassWordCheckVisible: Bool
        var newPasswordValid: Bool
        var newPasswordCheckedValid: Bool
    }
    
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            passWordIsCorrect: true,
            valid: false,
            newPassWord: "",
            newPassWordVisible: true,
            newPassWordCheck: "",
            newPassWordCheckVisible: true,
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
            return .just(.setNewPassWord(newPwd))
        case let .updateNewPassWordCheck(newPwd):
            return .just(.setNewPassWordCheck(newPwd))
        case .newPwdVisibleButtinDidTap:
            return .just(.setNewPassWordVisible(!currentState.newPassWordVisible))
        case .newPwdCheckVisibleButtonDidTap:
            return .just(.setNewPassWordCheckVisible(!currentState.newPassWordCheckVisible))
        }
    }
}

// MARK: - Reduce
extension NewPasswordReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setNewPassWord(newPwd):
            newState.newPassWord = newPwd
            newState.newPasswordValid = checkPasswordCheckValidation(pwd: newPwd, pwdChk: currentState.newPassWordCheck)
        case let .setNewPassWordCheck(newPwdCheck):
            newState.newPassWordCheck = newPwdCheck
            newState.newPasswordValid = checkPasswordCheckValidation(pwd: currentState.newPassWord, pwdChk: newPwdCheck)
        case let .setNewPassWordVisible(visible):
            newState.newPassWordVisible = visible
        case let.setNewPassWordCheckVisible(visible):
            newState.newPassWordCheckVisible = visible
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
        guard !state.newPassWord.isEmpty,
              !state.newPassWordCheck.isEmpty,
              checkPasswordCheckValidation(pwd: state.newPassWord, pwdChk: state.newPassWordCheck)
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

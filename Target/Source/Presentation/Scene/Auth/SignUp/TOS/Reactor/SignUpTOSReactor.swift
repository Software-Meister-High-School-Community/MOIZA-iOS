//
//  SignUpTOSReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SignUpTOSReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewDidAppear
        case checkBoxDidTap(type: TOSType)
        case allAgreeButtonDidTap(isOn: Bool)
        case continueButtonDidTap
    }
    enum Mutation{
        case setTOS([TOSModel])
    }
    struct State{
        var tos: [TOSModel] = []
        var isAgreed: Bool = false
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension SignUpTOSReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidAppear:
            return getTOS()
        case let .checkBoxDidTap(type):
            return changeCheckState(type: type)
        case let .allAgreeButtonDidTap(isOn):
            return allAgree(isOn: isOn)
        case .continueButtonDidTap:
            steps.accept(MoizaStep.signUpInformationIsRequired)
            return .empty()
        }
    }
}

// MARK: - Reduce
extension SignUpTOSReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTOS(tos):
            newState.tos = tos
            newState.isAgreed = valid(tos: tos)
        }
        return newState
    }
}


// MARK: - Method
private extension SignUpTOSReactor{
    func getTOS() -> Observable<Mutation>{
        return .just(.setTOS([
            .init(type: .privacy, isOn: false),
            .init(type: .userTOS, isOn: false)
        ]))
    }
    func changeCheckState(type: TOSType) -> Observable<Mutation>{
        return .just(.setTOS(currentState.tos.map{
            if $0.type == type {
                return TOSModel(type: type, isOn: !$0.isOn)
            }
            return $0
            })
        )
    }
    func allAgree(isOn: Bool) -> Observable<Mutation>{
        return .just(.setTOS(currentState.tos.map { return TOSModel(type: $0.type, isOn: isOn)} ))
    }
    
    func valid(tos: [TOSModel]) -> Bool {
        return tos.filter{ $0.isOn != true }.isEmpty
    }
}

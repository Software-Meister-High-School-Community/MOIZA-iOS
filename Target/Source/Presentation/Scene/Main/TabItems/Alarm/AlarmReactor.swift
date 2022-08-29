//
//  AlarmReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class AlarmReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case onAppear
        case noticeListButtonDidTap
    }
    enum Mutation {
        case setNotifications([NotificationList])
    }
    struct State {
        var pinnedNotice: NoticeList?
        var notificationList: [String: [NotificationList]]
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            notificationList: [:]
        )
    }
    
}

// MARK: - Mutate
extension AlarmReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .onAppear:
            return onAppear()
        case .noticeListButtonDidTap:
            steps.accept(MoizaStep.allNoticeListIsRequired)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension AlarmReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setNotifications(list):
            list.forEach { noti in
                let title = "\(noti.createdAt.year)/\(noti.createdAt.month)/\(noti.createdAt.day)"
                if newState.notificationList[title] == nil { newState.notificationList[title] = [] }
                newState.notificationList[title]?.append(noti)
            }
        }
        
        return newState
    }
}

// MARK: - Method
private extension AlarmReactor {
    func onAppear() -> Observable<Mutation> {
        return .concat([
            .just(.setNotifications([.dummy, .dummy, .dummy]))
        ])
    }
}

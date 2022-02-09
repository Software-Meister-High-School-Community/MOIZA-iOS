//
//  GraduateFileReactor.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import UIKit

final class GraduateFileReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case imageDidSelected(UIImage, String)
        case alert(title: String?, message: String)
        case cancelButtonDidTap
        case requestButtonDidTap
    }
    enum Mutation {
        case setImage(UIImage?)
        case setFilename(String)
    }
    struct State {
        var selectedImage: UIImage?
        var fileName: String
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            selectedImage: nil,
            fileName: ""
        )
    }
    
}

// MARK: - Mutate
extension GraduateFileReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .imageDidSelected(image, file):
            return .concat([
                .just(.setFilename(file)),
                .just(.setImage(image))
            ])
        case let .alert(title, message):
            steps.accept(MoizaStep.alert(title: title, message: message))
            return .empty()
        case .cancelButtonDidTap:
            return .concat([
                .just(.setImage(nil)),
                .just(.setFilename(""))
            ])
        case .requestButtonDidTap:
            
            return .empty()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension GraduateFileReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setImage(image):
            newState.selectedImage = image
        case let .setFilename(file):
            newState.fileName = file
        }
        return newState
    }
}

// MARK: - Method
private extension GraduateFileReactor {
    
}

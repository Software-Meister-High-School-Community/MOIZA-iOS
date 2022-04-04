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
        case imageDidSelected(Data?, String)
        case alert(title: String?, message: String, style: UIAlertController.Style, actions: [UIAlertAction])
        case errorAlert(title: String?, message: String)
        case cancelButtonDidTap
        case requestButtonDidTap
    }
    enum Mutation {
        case setImage(Data?)
        case setFilename(String)
        case setFileSize(Int?)
    }
    struct State {
        var selectedData: Data?
        var fileName: String
        var fileSize: String
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            selectedData: nil,
            fileName: "",
            fileSize: ""
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
                .just(.setImage(image)),
                .just(.setFileSize(image?.count))
            ])
        case let .alert(title, message, style, actions):
            steps.accept(MoizaStep.alert(title: title, message: message, style: style, actions: actions))
        case let .errorAlert(title, message):
            steps.accept(MoizaStep.errorAlert(title: title, message: message))
        case .cancelButtonDidTap:
            return .concat([
                .just(.setImage(nil)),
                .just(.setFilename("")),
                .just(.setFileSize(0))
            ])
        case .requestButtonDidTap:
            steps.accept(MoizaStep.signUpGraduateAuthSuccessIsRequired)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension GraduateFileReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setImage(data):
            newState.selectedData = data
        case let .setFilename(file):
            newState.fileName = file
        case let .setFileSize(size):
            newState.fileSize = formatToMB(size: size)
        }
        return newState
    }
}

// MARK: - Method
private extension GraduateFileReactor {
    func formatToMB(size: Int?) -> String {
        guard let size = size else { return "0 MB" }
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        let res = bcf.string(fromByteCount: Int64(size))
        return res
    }
}

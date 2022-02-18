//
//  PostBoardReactor.swift
//  MOIZA
//
//  Created by 임준화 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

import ReactorKit
import RxFlow
import RxRelay
import RxCocoa

final class PostBoardReactor: Reactor,Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag = DisposeBag()
    
    private let imageURLs: [String] = []
    
    // MARK: - Reactor
    enum Action{
        case updateTitle(String)
        case updateContent(String)
        case imageViewDidTap(index: Int)
        case postTypeButtonDidTap(PostType)
        case privacySettingButtonDidTap(PrivacySetting)
        case draftsButtonDidTap
        case registerButtonDidTap
    }
    enum Mutation{
        case setTitle(String)
        case setContent(String)
        case setImage(image: String)
        case setLoading(Bool)
        case setPostType(PostType)
        case setPrivacySetting(PrivacySetting)
        case setIsInValid
    }
    struct State{
        var title: String = ""
        var content: String = ""
        var imgae: String?
        var isLoading: Bool = false
        var postType: PostType = .question
        var privacySetting: PrivacySetting = .everyone
        var isInvalid: Bool = false
    }
    var initialState: State = State()
}

// MARK: - Mutate
extension PostBoardReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateTitle(title):
            return .just(.setTitle(title))
        case let .updateContent(content):
            return .just(.setContent(content))
        case let .imageViewDidTap(index):
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.setImage(image: imageURLs[index])).delay(.seconds(1), scheduler: MainScheduler.asyncInstance),
                Observable.just(Mutation.setLoading(false))
            ])
        case let .postTypeButtonDidTap(postType):
            return .just(.setPostType(postType))
        case let .privacySettingButtonDidTap(privacySetting):
            return .just(.setPrivacySetting(privacySetting))
        case .draftsButtonDidTap:
            return .empty()
        case .registerButtonDidTap:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension PostBoardReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation{
        case let .setTitle(title):
            newState.title = title
        case let .setContent(content):
            newState.content = content
        case let .setImage(image):
            newState.imgae = image
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setPostType(postType):
            newState.postType = postType
        case let .setPrivacySetting(privacySetting):
            newState.privacySetting = privacySetting
        case .setIsInValid:
            newState.isInvalid = false
        }
        newState.isInvalid = checkValidation(newState)
        return newState
    }
}
private extension PostBoardReactor{
    func checkValidation(_ state:State) -> Bool{
        guard !state.title.isEmpty,
              !state.content.isEmpty
        else {
            return false
        }
        return true
    }
}

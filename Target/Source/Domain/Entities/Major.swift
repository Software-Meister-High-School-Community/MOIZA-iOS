//
//  Major.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

enum Major: String, CaseIterable {
    case frontEnd = "FRONTEND"
    case backEnd = "BACKEND"
    case iOS = "IOS"
    case aOS = "ANDROID"
    case game = "GAME"
    case ai = "AI"
    case security = "SECURITY"
    case embeded = "EMBEDED"
    case design = "DESIGN"
}

extension Major {
    var display: String {
        switch self {
        case .frontEnd: return "FrontEnd"
        case .backEnd: return "BackEnd"
        case .iOS: return "iOS"
        case .aOS: return "aOS"
        case .game: return "Game"
        case .ai: return "AI"
        case .security: return "Security"
        case .embeded: return "Embeded"
        case .design: return "Design"
        }
    }
}

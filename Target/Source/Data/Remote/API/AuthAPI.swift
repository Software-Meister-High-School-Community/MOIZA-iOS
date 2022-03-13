import Foundation
import Moya

enum AuthAPI {
    case reissue
}

extension AuthAPI: MoizaAPI {
    var domain: MoizaDomain {
        return .auth
    }
    
    var urlPath: String {
        switch self {
        case .reissue:
            return "/tokens"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reissue:
            return .put
        }
    }
    
    var task: Task {
        switch self {
            
        default:
            return .requestPlain
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .reissue:
            return .refreshToken
        }
    }
}

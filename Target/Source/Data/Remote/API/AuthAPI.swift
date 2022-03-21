import Foundation
import Moya

enum AuthAPI {
    case login(req: LoginRequest)
    case sendVerification(SendVerificationRequest)
    case reissue
}

extension AuthAPI: MoizaAPI {
    var domain: MoizaDomain {
        return .auth
    }
    
    var urlPath: String {
        switch self {
        case .reissue, .login:
            return "/tokens"
        case .sendVerification:
            return "/email-verifications"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .sendVerification:
            return .post
        case .reissue:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)
        case let .sendVerification(req):
            return .requestJSONEncodable(req)
        default:
            return .requestPlain
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .reissue:
            return .refreshToken
        default:
            return JWTTokenType.none
        }
    }
}

import Foundation
import Moya

enum AuthAPI {
    case login(req: LoginRequest)
    case sendVerification(SendVerificationRequest)
    case checkVerification(CheckVerificationRequest)
    case checkIdValidations(id: String)
    case findId(email: String)
    case newPassword(req: ChangeNewPasswordRequest)
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
        case .sendVerification, .checkVerification:
            return "/email-verifications"
        case .checkIdValidations:
            return "/id-validations"
        case let .findId(email):
            return "/\(email)"
        case .newPassword:
            return "/passwords"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findId:
            return .get
        case .checkVerification, .checkIdValidations:
            return .head
        case .login, .sendVerification:
            return .post
        case .reissue:
            return .put
        case .newPassword:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)
        case let .sendVerification(req):
            return .requestJSONEncodable(req)
        case let .checkVerification(req):
            return .requestJSONEncodable(req)
        case let .checkIdValidations(id):
            return .requestParameters(parameters: [
                "account_id": id
            ], encoding: JSONEncoding.default)
        case let .newPassword(req):
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

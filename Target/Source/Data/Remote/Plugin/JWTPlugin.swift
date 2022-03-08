import Moya

protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

enum JWTTokenType {

    case none

    case accessToken
    case refreshToken

    public var headerString: String? {
        switch self {
        case .accessToken:
            return "Authorization"
        case .refreshToken:
            return "X-Refresh-Token"
        default:
            return nil
        }
    }
}

final class JWTPlugin: PluginType {
    private let ds = KeychainLocal.shared
    func prepare(
        _ request: URLRequest,
        target: TargetType
    ) throws -> URLRequest {
        guard let authorizable = target as? JWTTokenAuthorizable,
              let tokenType = authorizable.jwtTokenType,
              tokenType != .none
        else { return request }
        
        var request = request
        
        let token = "Bearer \(getToken(type: tokenType))"
        request.addValue(token, forHTTPHeaderField: tokenType.headerString ?? "")
        return request
    }
    
    func didReceive(
        _ result: Result<Response, MoyaError>,
        target: TargetType
    ) {
        switch result {
        case let .success(res):
            if let newToken = try? res.map(TokenDTO.self) {
                self.setToken(token: newToken)
            }
        default:
            break
        }
    }
}

private extension JWTPlugin {
    
    func getToken(type: JWTTokenType) -> String {
        switch type {
        case .accessToken:
            return getAccessToken()
        case .refreshToken:
            return getRefreshToken()
        case .none:
            return ""
        }
    }
    
    func getAccessToken() -> String {
        do {
            return try ds.fetchAccessToken()
        } catch {
            return ""
        }
    }
    
    func getRefreshToken() -> String {
        do {
            return try ds.fetchRefreshToken()
        } catch {
            return ""
        }
    }
    
    func setToken(token: TokenDTO) {
        ds.saveAccessToken(token.accessToken)
        ds.saveRefreshToken(token.refreshToken)
        ds.saveExpiredAt(token.expiredAt)
    }
}

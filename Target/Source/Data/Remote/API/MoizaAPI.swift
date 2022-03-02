import Moya

protocol MoizaAPI: TargetType, JWTTokenAuthorizable {
    var domain: MoizaDomain { get }
    var urlPath: String { get }
}

extension MoizaAPI {
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        return domain.url + urlPath
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

enum MoizaDomain: String {
    case auth
}

extension MoizaDomain {
    var url: String {
        return "/\(self.rawValue)"
    }
}

struct CheckVerificationRequest: Encodable {
    let email: String
    let authCode: String
    let type: AuthType
    
    enum CodingKeys: String, CodingKey {
        case email, type
        case authCode = "auth_code"
    }
}

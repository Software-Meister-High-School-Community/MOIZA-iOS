struct LoginRequest: Encodable {
    let accountId: String
    let password: String
    let deviceToken: String
    
    enum CodingKeys: String, CodingKey {
        case password
        case accountId = "account_id"
        case deviceToken = "device_token"
    }
}

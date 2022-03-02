
struct TokenDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiredAt = "expired_at"
    }
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}

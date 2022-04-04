struct FindIdResponse: Decodable {
    let accountId: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case name
        case accountId = "account_id"
    }
}

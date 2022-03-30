struct ChangeNewPasswordRequest: Encodable {
    let accountId: String
    let newPassword: String
    
    enum CodingKeys: String, CodingKey {
        case newPassword = "new_password"
        case accountId = "account_id"
    }
}

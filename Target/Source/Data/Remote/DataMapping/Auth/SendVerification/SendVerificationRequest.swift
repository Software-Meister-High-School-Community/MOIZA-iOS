struct SendVerificationRequest: Encodable {
    let scope: SendScope
    let type: AuthType
    let value: String
}

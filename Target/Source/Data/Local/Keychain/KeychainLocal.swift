import Foundation
import SwiftDate

final class KeychainLocal {
    static let shared = KeychainLocal()
    private let keychain = Keychain.shared
    private init(){}
    
    func saveAccessToken(_ token: String) {
        keychain.save(type: .accessToken, value: token)
    }
    
    func fetchAccessToken() throws -> String {
        return try keychain.load(type: .accessToken)
    }
    
    func saveRefreshToken(_ token: String) {
        keychain.save(type: .refreshToken, value: token)
    }
    
    func fetchRefreshToken() throws -> String {
        return try keychain.load(type: .refreshToken)
    }
    
    func saveExpiredAt(_ expiredAt: String) {
        keychain.save(type: .expiredAt, value: expiredAt)
    }
    
    func fetchExpiredAt() throws -> Date {
        return try keychain.load(type: .expiredAt).toMoizaDateWithString()
    }
}

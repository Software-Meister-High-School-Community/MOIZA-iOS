
import UIKit

public struct FollowerUserList: Equatable {
    public let userID: String
    public let name: String
    public let profileImageUrl: String
    public let school: School
    public let userScope: UserScope
    public let isFollow: Bool
    
}

public extension FollowerUserList {
    static let dummy: FollowerUserList = .init(
        userID: UUID().uuidString,
        name: ["김성훈", "최형우", "김상은", "남화진인"].randomElement() ?? "",
        profileImageUrl: [
            "https://avatars.githubusercontent.com/u/91456952?s=100&v=4",
            "https://avatars.githubusercontent.com/u/85563909?s=100&v=4",
            "https://avatars.githubusercontent.com/u/80795917?s=100&v=4",
            "https://avatars.githubusercontent.com/u/67373938?v=4"
        ].randomElement() ?? "",
        school: .allCases.randomElement() ?? .dgsm,
        userScope: .allCases.randomElement() ?? .student,
        isFollow: .random()
    )
}

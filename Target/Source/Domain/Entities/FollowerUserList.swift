
import UIKit

public struct FollowerUserList: Equatable {
    public init(userId: Int, name: String, profileImageURL: String, school: School, userScope: UserScope, isFollow: Bool){
        self.userID = userId
        self.name = name
        self.profileImageUrl = profileImageURL
        self.school = school
        self.userScope = userScope
        self.isFollow = isFollow
    }

    public let userID: Int
    public let name: String
    public let profileImageUrl: String
    public let school: School
    public let userScope: UserScope
    public let isFollow: Bool
    
}

public extension FollowerUserList {
    static let dummy: FollowerUserList = .init(
        userId: .random(in: 0...100),
        name: ["김성훈", "최형우", "김상은", "남화진인"].randomElement() ?? "",
        profileImageURL: [
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


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
        name: "최형우",
        profileImageURL: "https://avatars.githubusercontent.com/u/74440939?v=4",
        school: .dgsm,
        userScope: UserScope.user,
        isFollow: .random()
    )
}

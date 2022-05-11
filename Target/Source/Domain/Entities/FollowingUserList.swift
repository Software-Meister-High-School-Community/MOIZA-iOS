
import UIKit

public struct FollowingUserList: Equatable {
    public init(userId: Int, name: String, profileImageURL: String, school: School, userScope: UserScope, isFollow: Bool){
        self.userID = userId
        self.name = name
        self.profileImageUrl = profileImageURL
        self.school = school
        self.userScope = userScope
        self.isFollow = isFollow
    }
    
    public init(){
        self.userID = 1
        self.name = ""
        self.profileImageUrl = ""
        self.school = .gsm
        self.userScope = .user
        self.isFollow = true
    }
    
    public let userID: Int
    public let name: String
    public let profileImageUrl: String
    public let school: School
    public let userScope: UserScope
    public let isFollow: Bool
}

public extension FollowingUserList {
    static let dummy: FollowingUserList = .init(
        userId: .random(in: 0...100),
        name: "최형우",
        profileImageURL: "https://avatars.githubusercontent.com/u/74440939?v=4",
        school: .gsm,
        userScope: UserScope.user,
        isFollow: .random()
    )
}

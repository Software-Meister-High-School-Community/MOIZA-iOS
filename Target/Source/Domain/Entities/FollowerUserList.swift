
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

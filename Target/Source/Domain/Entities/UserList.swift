
import UIKit

public struct UserList: Equatable {
    init(userId: Int, name: String, profileImageURL: String, school: School, userScope: UserScope, isFollow: Bool){
        self.userID = userId
        self.name = name
        self.profileImageURL = profileImageURL
        self.school = school
        self.userScope = userScope
        self.isFollow = isFollow
    }
    
    public init(){
        self.userID = 1
        self.name = ""
        self.profileImageURL = ""
        self.school = .gsm
        self.userScope = .user
        self.isFollow = true
    }
    
    public let userID: Int
    public let name: String
    public let profileImageURL: String
    let school: School
    let userScope: UserScope
    public let isFollow: Bool
}

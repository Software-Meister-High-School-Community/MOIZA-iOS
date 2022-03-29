import Foundation

struct Follow: Codable {
    let isMine: Bool
    let userList: [UserList]

    enum CodingKeys: String, CodingKey {
        case isMine = "is_mine"
        case userList = "user_list"
    }
}
struct UserList: Codable {
    let userID: Int
    let name: String
    let profileImageURL: String
    let school: School
    let userScope: UserScope
    let isFollow: Bool

    enum CodingKeys: String, CodingKey {
        case school,name
        case userID = "user_id"
        case profileImageURL = "profile_image_url"
        case userScope = "user_scope"
        case isFollow = "is_follow"
    }
}


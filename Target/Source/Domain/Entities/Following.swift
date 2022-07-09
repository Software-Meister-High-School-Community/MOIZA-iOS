import Foundation

struct Following: Equatable {
    let isMine: Bool
    let followingUserList: [FollowingUserList]

    enum CodingKeys: String, CodingKey {
        case isMine = "is_mine"
        case followingUserList = "user_list"
    }
}

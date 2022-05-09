import Foundation

struct Follower: Equatable {
    let isMine: Bool
    let followerUserList: [FollowerUserList]

    enum CodingKeys: String, CodingKey {
        case isMine = "is_mine"
        case userList = "user_list"
    }
}

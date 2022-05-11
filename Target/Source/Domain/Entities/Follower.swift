import Foundation

struct Follower: Equatable {
    let isMine: Bool
    let followerUserList: [FollowerUserList]

    enum CodingKeys: String, CodingKey {
        case isMine = "is_mine"
        case followerUserList = "user_list"
    }
}

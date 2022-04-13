import Foundation

struct Follow: Equatable {
    let isMine: Bool
    let userList: [UserList]

    enum CodingKeys: String, CodingKey {
        case isMine = "is_mine"
        case userList = "user_list"
    }
}
